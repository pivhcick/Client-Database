import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_status.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../../../core/utils/notification_helper.dart';
import '../../../../core/utils/logger.dart';
import '../../../notifications/presentation/providers/notification_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// Reminder provider
///
/// Manages state for reminders and handles notification scheduling.
class ReminderProvider extends ChangeNotifier {
  final ReminderRepository _repository;
  final NotificationHelper _notificationHelper;
  NotificationProvider? _notificationProvider;
  AuthProvider? _authProvider;
  Timer? _statusUpdateTimer;
  bool _timerStarted = false; // Flag to prevent multiple timer starts

  ReminderProvider({
    required ReminderRepository repository,
    required NotificationHelper notificationHelper,
    NotificationProvider? notificationProvider,
    AuthProvider? authProvider,
  })  : _repository = repository,
        _notificationHelper = notificationHelper,
        _notificationProvider = notificationProvider,
        _authProvider = authProvider {
    // Start periodic status check every 30 seconds
    _startStatusUpdateTimer();
  }

  /// Update dependencies without recreating the provider
  void updateDependencies({
    NotificationProvider? notificationProvider,
    AuthProvider? authProvider,
  }) {
    _notificationProvider = notificationProvider;
    _authProvider = authProvider;
  }

  List<Reminder> _reminders = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  String? _currentCompanyId;
  String? _currentUserId;
  bool _disposed = false;

  // Getters
  List<Reminder> get reminders => _reminders;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  /// Get pending reminders (not yet delivered or cancelled)
  List<Reminder> get pendingReminders =>
      _reminders.where((r) => r.status == ReminderStatus.pending).toList();

  /// Get delivered reminders
  List<Reminder> get deliveredReminders =>
      _reminders.where((r) => r.status == ReminderStatus.delivered).toList();

  /// Load all reminders for a user
  Future<void> loadReminders(String userId) async {
    _currentUserId = userId;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    _safeNotifyListeners();

    try {
      _reminders = await _repository.getAllReminders(userId);
      _hasError = false;

      // Update expired reminders to delivered status
      await updateExpiredReminders();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _reminders = [];
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  /// Load reminders for a company
  Future<void> loadRemindersByCompany(String companyId) async {
    AppLogger.database('loadRemindersByCompany called for companyId: $companyId', 'ReminderProvider');
    _currentCompanyId = companyId;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    _safeNotifyListeners();

    try {
      _reminders = await _repository.getByCompanyId(companyId);
      AppLogger.success('Loaded ${_reminders.length} reminders from database', 'ReminderProvider');
      _hasError = false;

      // Update expired reminders to delivered status
      await updateExpiredReminders();
      AppLogger.debug('After updateExpiredReminders: ${_reminders.length} reminders', 'ReminderProvider');
    } catch (e) {
      AppLogger.error('Error loading reminders', e, null, 'ReminderProvider');
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _reminders = [];
    } finally {
      _isLoading = false;
      AppLogger.debug('loadRemindersByCompany complete. Final count: ${_reminders.length}', 'ReminderProvider');
      _safeNotifyListeners();
    }
  }

  /// Refresh current reminders
  Future<void> refreshReminders() async {
    if (_currentCompanyId != null) {
      await loadRemindersByCompany(_currentCompanyId!);
    } else if (_currentUserId != null) {
      await loadReminders(_currentUserId!);
    }
  }

  /// Create new reminder and schedule notification
  Future<void> createReminder({
    required String companyId,
    required String title,
    String? description,
    required DateTime scheduledFor,
    required String createdByUserId,
  }) async {
    final reminder = await _repository.createReminder(
      companyId: companyId,
      title: title,
      description: description,
      scheduledFor: scheduledFor,
      createdByUserId: createdByUserId,
    );

    // Schedule notification
    await _scheduleNotification(reminder);

    // Create notification record immediately (will be shown when scheduled time comes)
    // Don't let this block the reminder creation flow
    try {
      await _createNotificationRecord(reminder);
    } catch (e) {
      AppLogger.warning('Failed to create notification record, but reminder was created: $e', 'ReminderProvider');
    }

    // Note: List reloading is handled by the UI after dialog closes
    // to avoid race conditions and empty list issues
  }

  /// Update reminder and reschedule notification
  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? scheduledFor,
  }) async {
    // Find original reminder
    final originalReminder =
        _reminders.firstWhere((r) => r.id == reminderId);

    // Update in database
    final updatedReminder = await _repository.updateReminder(
      reminderId: reminderId,
      title: title,
      description: description,
      scheduledFor: scheduledFor,
    );

    // Cancel old notification if status is still pending
    if (originalReminder.status == ReminderStatus.pending) {
      await _cancelNotification(reminderId);
    }

    // Reschedule notification if status is still pending and date changed
    if (updatedReminder.status == ReminderStatus.pending) {
      await _scheduleNotification(updatedReminder);
    }

    // Reload reminders after update
    await refreshReminders();
  }

  /// Cancel reminder and cancel notification
  Future<void> cancelReminder(String reminderId) async {
    await _repository.updateReminderStatus(
      reminderId: reminderId,
      status: ReminderStatus.cancelled,
    );

    // Cancel notification
    await _cancelNotification(reminderId);

    // Reload reminders after cancel
    await refreshReminders();
  }

  /// Mark reminder as delivered
  Future<void> markAsDelivered(String reminderId) async {
    await _repository.updateReminderStatus(
      reminderId: reminderId,
      status: ReminderStatus.delivered,
    );

    // Reload reminders
    await refreshReminders();
  }

  /// Delete reminder and cancel notification
  Future<void> deleteReminder(String reminderId) async {
    // Cancel notification first
    await _cancelNotification(reminderId);

    // Delete from database
    await _repository.deleteReminder(reminderId);

    // Reload reminders after deletion
    await refreshReminders();
  }

  /// Update expired pending reminders to delivered status
  /// Call this method manually to force check and update expired reminders
  ///
  /// Uses PostgreSQL RPC function for atomic database-level update
  Future<void> updateExpiredReminders() async {
    try {
      AppLogger.database('Updating expired reminders via database RPC...', 'ReminderProvider');

      // Get currently expired reminders before updating
      final expiredReminders = _reminders
          .where((r) =>
              r.status == ReminderStatus.pending &&
              r.scheduledFor.isBefore(DateTime.now()))
          .toList();

      // Call database RPC function to update all expired reminders atomically
      final updatedCount = await _repository.updateExpiredRemindersInDatabase();

      AppLogger.success('Database RPC updated $updatedCount reminders', 'ReminderProvider');

      // Reload reminders to get updated statuses from database
      if (_currentCompanyId != null) {
        _reminders = await _repository.getByCompanyId(_currentCompanyId!);
      } else if (_currentUserId != null) {
        _reminders = await _repository.getAllReminders(_currentUserId!);
      }

      AppLogger.success('Reminders reloaded from database', 'ReminderProvider');

      // Note: Notification records are created when reminder is first scheduled
      // No need to create them again when status changes to delivered
      AppLogger.debug('${expiredReminders.length} reminders were marked as delivered', 'ReminderProvider');
      AppLogger.debug('Notification records should have been created during reminder creation', 'ReminderProvider');
    } catch (e) {
      AppLogger.error('Error updating expired reminders', e, null, 'ReminderProvider');
      // Don't rethrow - just log the error
    }
  }

  /// Create notification record for a delivered reminder
  Future<void> _createNotificationRecord(Reminder reminder) async {
    AppLogger.notification('_createNotificationRecord called for reminder ${reminder.id}', 'ReminderProvider');
    AppLogger.debug('_notificationProvider: ${_notificationProvider != null ? "available" : "NULL"}', 'ReminderProvider');
    AppLogger.debug('_authProvider: ${_authProvider != null ? "available" : "NULL"}', 'ReminderProvider');
    AppLogger.debug('_authProvider.currentUser: ${_authProvider?.currentUser != null ? "available" : "NULL"}', 'ReminderProvider');

    if (_notificationProvider == null ||
        _authProvider == null ||
        _authProvider!.currentUser == null) {
      AppLogger.warning('Cannot create notification record: missing dependencies', 'ReminderProvider');
      AppLogger.debug('Skipping notification record creation', 'ReminderProvider');
      return;
    }

    try {
      final currentUser = _authProvider!.currentUser!;
      final companyName = reminder.companyName ?? 'Компания';

      AppLogger.notification('Creating notification record:', 'ReminderProvider');
      AppLogger.debug('reminderId: ${reminder.id}', 'ReminderProvider');
      AppLogger.debug('companyId: ${reminder.companyId}', 'ReminderProvider');
      AppLogger.debug('userId: ${currentUser.id}', 'ReminderProvider');
      AppLogger.debug('organizationId: ${currentUser.organizationId}', 'ReminderProvider');
      AppLogger.debug('title: ${reminder.title}', 'ReminderProvider');

      await _notificationProvider!.createNotificationRecord(
        reminderId: reminder.id,
        companyId: reminder.companyId,
        userId: currentUser.id,
        organizationId: currentUser.organizationId,
        title: reminder.title,
        body: companyName +
            (reminder.description != null ? '\n${reminder.description}' : ''),
      );

      AppLogger.success('Notification record created for reminder ${reminder.id}', 'ReminderProvider');
    } catch (e, stackTrace) {
      AppLogger.error('Error creating notification record', e, stackTrace, 'ReminderProvider');
      // Don't rethrow - notification record creation shouldn't block the update
    }
  }

  /// Schedule notification for a reminder
  Future<void> _scheduleNotification(Reminder reminder) async {
    AppLogger.notification('Scheduling notification for reminder:', 'ReminderProvider');
    AppLogger.debug('ID: ${reminder.id}', 'ReminderProvider');
    AppLogger.debug('Notification ID (hashCode): ${reminder.id.hashCode}', 'ReminderProvider');
    AppLogger.debug('Title: ${reminder.title}', 'ReminderProvider');
    AppLogger.debug('Scheduled for: ${reminder.scheduledFor}', 'ReminderProvider');
    AppLogger.debug('Current time: ${DateTime.now()}', 'ReminderProvider');
    AppLogger.debug('Is in future: ${reminder.scheduledFor.isAfter(DateTime.now())}', 'ReminderProvider');
    AppLogger.debug('Status: ${reminder.status}', 'ReminderProvider');

    // Only schedule if in the future and status is pending
    if (reminder.scheduledFor.isAfter(DateTime.now()) &&
        reminder.status == ReminderStatus.pending) {
      final notificationId = reminder.id.hashCode;
      final companyName = reminder.companyName ?? 'Компания';

      // Create payload with companyId and reminderId as JSON
      final payload = jsonEncode({
        'reminderId': reminder.id,
        'companyId': reminder.companyId,
      });

      AppLogger.notification('Calling notificationHelper.scheduleNotification...', 'ReminderProvider');
      AppLogger.debug('Payload: $payload', 'ReminderProvider');

      await _notificationHelper.scheduleNotification(
        id: notificationId,
        title: reminder.title,
        body: '$companyName${reminder.description != null ? '\n${reminder.description}' : ''}',
        scheduledDate: reminder.scheduledFor,
        payload: payload,
      );

      AppLogger.success('Notification scheduled successfully', 'ReminderProvider');

      // Check pending notifications
      final pending = await _notificationHelper.getPendingNotifications();
      AppLogger.debug('Total pending notifications: ${pending.length}', 'ReminderProvider');
      for (final p in pending) {
        AppLogger.debug('- [${p.id}] ${p.title} - ${p.body}', 'ReminderProvider');
      }
    } else {
      AppLogger.warning('Notification NOT scheduled:', 'ReminderProvider');
      if (!reminder.scheduledFor.isAfter(DateTime.now())) {
        AppLogger.debug('Reason: Time is in the past', 'ReminderProvider');
      }
      if (reminder.status != ReminderStatus.pending) {
        AppLogger.debug('Reason: Status is not pending (${reminder.status})', 'ReminderProvider');
      }
    }
  }

  /// Cancel notification for a reminder
  Future<void> _cancelNotification(String reminderId) async {
    final notificationId = reminderId.hashCode;
    await _notificationHelper.cancelNotification(notificationId);
  }

  /// Start periodic timer to check and update expired reminder statuses
  void _startStatusUpdateTimer() {
    // Prevent multiple timer starts
    if (_timerStarted) {
      AppLogger.warning('Timer already started, skipping...', 'ReminderProvider');
      return;
    }

    // Cancel existing timer if any (safety check)
    _statusUpdateTimer?.cancel();

    // Check every 30 seconds for expired reminders
    _statusUpdateTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) async {
        // Only update if we have loaded reminders and not currently loading
        if (_reminders.isNotEmpty && !_isLoading && !_disposed) {
          AppLogger.timer('Checking for expired reminders...', 'ReminderProvider');
          try {
            await updateExpiredReminders();
            _safeNotifyListeners();
          } catch (e) {
            AppLogger.error('Timer: Error updating expired reminders', e, null, 'ReminderProvider');
          }
        }
      },
    );
    _timerStarted = true;
    AppLogger.success('Status update timer started (every 30 seconds)', 'ReminderProvider');
  }

  /// Safe notifyListeners that checks if disposed
  void _safeNotifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _statusUpdateTimer?.cancel();
    _statusUpdateTimer = null;
    _timerStarted = false;
    AppLogger.info('Status update timer cancelled and disposed', 'ReminderProvider');
    super.dispose();
  }
}
