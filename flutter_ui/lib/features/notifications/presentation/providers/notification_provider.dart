import 'package:flutter/foundation.dart';
import '../../domain/entities/notification_record.dart';
import '../../data/repositories/notification_record_repository.dart';

/// Notification provider
///
/// Manages notification records state and operations.
class NotificationProvider extends ChangeNotifier {
  final NotificationRecordRepository _repository;

  List<NotificationRecord> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _unreadCount = 0;

  NotificationProvider({NotificationRecordRepository? repository})
      : _repository = repository ?? NotificationRecordRepository();

  // Getters
  List<NotificationRecord> get notifications => _notifications;
  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;
  int get unreadCount => _unreadCount;

  /// Load all notifications
  Future<void> loadNotifications() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notifications = await _repository.getNotifications();
      await _loadUnreadCount();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      if (kDebugMode) {
        print('Error loading notifications: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load unread count
  Future<void> _loadUnreadCount() async {
    try {
      _unreadCount = await _repository.getUnreadCount();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading unread count: $e');
      }
    }
  }

  /// Refresh notifications (pull-to-refresh)
  Future<void> refreshNotifications() async {
    try {
      _notifications = await _repository.getNotifications();
      await _loadUnreadCount();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      if (kDebugMode) {
        print('Error refreshing notifications: $e');
      }
      notifyListeners();
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);

      // Update local state
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(
          isRead: true,
          readAt: DateTime.now(),
        );
        _unreadCount = (_unreadCount - 1).clamp(0, double.infinity).toInt();
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error marking notification as read: $e');
      }
      rethrow;
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead();

      // Update local state
      _notifications = _notifications
          .map((n) => n.copyWith(
                isRead: true,
                readAt: n.isRead ? n.readAt : DateTime.now(),
              ))
          .toList();
      _unreadCount = 0;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error marking all as read: $e');
      }
      rethrow;
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.deleteNotification(notificationId);

      // Update local state
      final wasUnread =
          _notifications.firstWhere((n) => n.id == notificationId).isRead ==
              false;
      _notifications.removeWhere((n) => n.id == notificationId);
      if (wasUnread) {
        _unreadCount = (_unreadCount - 1).clamp(0, double.infinity).toInt();
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting notification: $e');
      }
      rethrow;
    }
  }

  /// Delete all read notifications
  Future<void> deleteAllRead() async {
    try {
      await _repository.deleteAllRead();

      // Update local state
      _notifications.removeWhere((n) => n.isRead);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting read notifications: $e');
      }
      rethrow;
    }
  }

  /// Create notification record (called when notification is delivered)
  Future<void> createNotificationRecord({
    required String reminderId,
    required String companyId,
    required String userId,
    required String organizationId,
    required String title,
    String? body,
  }) async {
    print('🔔 NotificationProvider.createNotificationRecord called');
    print('   reminderId: $reminderId');
    print('   companyId: $companyId');
    print('   userId: $userId');
    print('   organizationId: $organizationId');
    print('   title: $title');

    try {
      print('🔔 Calling repository.createNotificationRecord...');
      final notification = await _repository.createNotificationRecord(
        reminderId: reminderId,
        companyId: companyId,
        userId: userId,
        organizationId: organizationId,
        title: title,
        body: body,
      );

      print('✅ Notification record created in DB: ${notification.id}');
      print('   Current notifications count: ${_notifications.length}');

      // Add to local list and update count
      _notifications.insert(0, notification);
      _unreadCount++;

      print('✅ Added to local list. New count: ${_notifications.length}');
      print('✅ Unread count: $_unreadCount');

      notifyListeners();
      print('✅ notifyListeners() called');
    } catch (e) {
      print('❌ Error creating notification record: $e');
      if (kDebugMode) {
        print('Stack trace: ${StackTrace.current}');
      }
      // Re-throw to show error to user for debugging
      rethrow;
    }
  }
}
