import 'package:flutter/foundation.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_status.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../../../core/utils/notification_helper.dart';

/// Reminder provider
///
/// Manages state for reminders and handles notification scheduling.
class ReminderProvider extends ChangeNotifier {
  final ReminderRepository _repository;
  final NotificationHelper _notificationHelper;

  ReminderProvider({
    required ReminderRepository repository,
    required NotificationHelper notificationHelper,
  })  : _repository = repository,
        _notificationHelper = notificationHelper;

  List<Reminder> _reminders = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  String? _currentCompanyId;
  String? _currentUserId;

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
    notifyListeners();

    try {
      _reminders = await _repository.getAllReminders(userId);
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _reminders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load reminders for a company
  Future<void> loadRemindersByCompany(String companyId) async {
    _currentCompanyId = companyId;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      _reminders = await _repository.getByCompanyId(companyId);
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _reminders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
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

    // Reload reminders after creation
    if (_currentCompanyId != null) {
      await loadRemindersByCompany(_currentCompanyId!);
    } else if (_currentUserId != null) {
      await loadReminders(_currentUserId!);
    }
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

  /// Schedule notification for a reminder
  Future<void> _scheduleNotification(Reminder reminder) async {
    // Only schedule if in the future and status is pending
    if (reminder.scheduledFor.isAfter(DateTime.now()) &&
        reminder.status == ReminderStatus.pending) {
      final notificationId = reminder.id.hashCode;
      final companyName = reminder.companyName ?? 'Компания';

      await _notificationHelper.scheduleNotification(
        id: notificationId,
        title: reminder.title,
        body: '$companyName${reminder.description != null ? '\n${reminder.description}' : ''}',
        scheduledDate: reminder.scheduledFor,
        payload: reminder.id,
      );
    }
  }

  /// Cancel notification for a reminder
  Future<void> _cancelNotification(String reminderId) async {
    final notificationId = reminderId.hashCode;
    await _notificationHelper.cancelNotification(notificationId);
  }
}
