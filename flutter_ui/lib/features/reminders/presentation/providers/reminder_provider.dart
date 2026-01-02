import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_status.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../../../core/utils/notification_helper.dart';
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
    print('🔄 loadRemindersByCompany called for companyId: $companyId');
    _currentCompanyId = companyId;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    _safeNotifyListeners();

    try {
      _reminders = await _repository.getByCompanyId(companyId);
      print('✅ Loaded ${_reminders.length} reminders from database');
      _hasError = false;

      // Update expired reminders to delivered status
      await updateExpiredReminders();
      print('✅ After updateExpiredReminders: ${_reminders.length} reminders');
    } catch (e) {
      print('❌ Error loading reminders: $e');
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _reminders = [];
    } finally {
      _isLoading = false;
      print('✅ loadRemindersByCompany complete. Final count: ${_reminders.length}');
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
      print('⚠️ Failed to create notification record, but reminder was created: $e');
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
      print('🔄 Updating expired reminders via database RPC...');

      // Get currently expired reminders before updating
      final expiredReminders = _reminders
          .where((r) =>
              r.status == ReminderStatus.pending &&
              r.scheduledFor.isBefore(DateTime.now()))
          .toList();

      // Call database RPC function to update all expired reminders atomically
      final updatedCount = await _repository.updateExpiredRemindersInDatabase();

      print('✅ Database RPC updated $updatedCount reminders');

      // Reload reminders to get updated statuses from database
      if (_currentCompanyId != null) {
        _reminders = await _repository.getByCompanyId(_currentCompanyId!);
      } else if (_currentUserId != null) {
        _reminders = await _repository.getAllReminders(_currentUserId!);
      }

      print('✅ Reminders reloaded from database');

      // Note: Notification records are created when reminder is first scheduled
      // No need to create them again when status changes to delivered
      print('📝 ${expiredReminders.length} reminders were marked as delivered');
      print('   Notification records should have been created during reminder creation');
    } catch (e) {
      print('❌ Error updating expired reminders: $e');
      // Don't rethrow - just log the error
    }
  }

  /// Create notification record for a delivered reminder
  Future<void> _createNotificationRecord(Reminder reminder) async {
    print('📝 _createNotificationRecord called for reminder ${reminder.id}');
    print('   _notificationProvider: ${_notificationProvider != null ? "available" : "NULL"}');
    print('   _authProvider: ${_authProvider != null ? "available" : "NULL"}');
    print('   _authProvider.currentUser: ${_authProvider?.currentUser != null ? "available" : "NULL"}');

    if (_notificationProvider == null ||
        _authProvider == null ||
        _authProvider!.currentUser == null) {
      print('⚠️ Cannot create notification record: missing dependencies');
      print('   Skipping notification record creation');
      return;
    }

    try {
      final currentUser = _authProvider!.currentUser!;
      final companyName = reminder.companyName ?? 'Компания';

      print('📝 Creating notification record:');
      print('   reminderId: ${reminder.id}');
      print('   companyId: ${reminder.companyId}');
      print('   userId: ${currentUser.id}');
      print('   organizationId: ${currentUser.organizationId}');
      print('   title: ${reminder.title}');

      await _notificationProvider!.createNotificationRecord(
        reminderId: reminder.id,
        companyId: reminder.companyId,
        userId: currentUser.id,
        organizationId: currentUser.organizationId,
        title: reminder.title,
        body: companyName +
            (reminder.description != null ? '\n${reminder.description}' : ''),
      );

      print('✅ Notification record created for reminder ${reminder.id}');
    } catch (e) {
      print('❌ Error creating notification record: $e');
      print('   Stack trace: ${StackTrace.current}');
      // Don't rethrow - notification record creation shouldn't block the update
    }
  }

  /// Schedule notification for a reminder
  Future<void> _scheduleNotification(Reminder reminder) async {
    print('📅 Scheduling notification for reminder:');
    print('  ID: ${reminder.id}');
    print('  Notification ID (hashCode): ${reminder.id.hashCode}');
    print('  Title: ${reminder.title}');
    print('  Scheduled for: ${reminder.scheduledFor}');
    print('  Current time: ${DateTime.now()}');
    print('  Is in future: ${reminder.scheduledFor.isAfter(DateTime.now())}');
    print('  Status: ${reminder.status}');

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

      print('✅ Calling notificationHelper.scheduleNotification...');
      print('  Payload: $payload');

      await _notificationHelper.scheduleNotification(
        id: notificationId,
        title: reminder.title,
        body: '$companyName${reminder.description != null ? '\n${reminder.description}' : ''}',
        scheduledDate: reminder.scheduledFor,
        payload: payload,
      );

      print('✅ Notification scheduled successfully');

      // Check pending notifications
      final pending = await _notificationHelper.getPendingNotifications();
      print('📋 Total pending notifications: ${pending.length}');
      for (final p in pending) {
        print('  - [${p.id}] ${p.title} - ${p.body}');
      }
    } else {
      print('⚠️ Notification NOT scheduled:');
      if (!reminder.scheduledFor.isAfter(DateTime.now())) {
        print('  Reason: Time is in the past');
      }
      if (reminder.status != ReminderStatus.pending) {
        print('  Reason: Status is not pending (${reminder.status})');
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
    // Cancel existing timer if any
    _statusUpdateTimer?.cancel();

    // Check every 30 seconds for expired reminders
    _statusUpdateTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) async {
        // Only update if we have loaded reminders and not currently loading
        if (_reminders.isNotEmpty && !_isLoading && !_disposed) {
          print('⏰ Timer: Checking for expired reminders...');
          try {
            await updateExpiredReminders();
            _safeNotifyListeners();
          } catch (e) {
            print('❌ Timer: Error updating expired reminders: $e');
          }
        }
      },
    );
    print('✅ Status update timer started (every 30 seconds)');
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
    print('🛑 Status update timer cancelled');
    super.dispose();
  }
}
