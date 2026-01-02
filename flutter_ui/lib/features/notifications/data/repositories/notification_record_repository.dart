import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notification_record_model.dart';
import '../../domain/entities/notification_record.dart';

/// Repository for notification records
///
/// Handles all database operations for notification records.
class NotificationRecordRepository {
  final SupabaseClient _supabase;

  NotificationRecordRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  /// Get all notifications for current user
  Future<List<NotificationRecord>> getNotifications({
    bool? isRead,
    int? limit,
  }) async {
    try {
      // Build query with filters and JOIN to companies table
      var baseQuery = _supabase
          .from('notification_records')
          .select('*, companies(name)');

      if (isRead != null) {
        baseQuery = baseQuery.eq('is_read', isRead);
      }

      // Execute query with ordering and limit
      final queryBuilder = baseQuery.order('delivered_at', ascending: false);

      final data = limit != null
          ? await queryBuilder.limit(limit)
          : await queryBuilder;

      return (data as List)
          .map((json) => NotificationRecordModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Failed to load notifications: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }

  /// Get count of unread notifications
  Future<int> getUnreadCount() async {
    try {
      final response = await _supabase
          .from('notification_records')
          .select('id')
          .eq('is_read', false);

      return (response as List).length;
    } on PostgrestException catch (e) {
      throw Exception('Failed to get unread count: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }

  /// Create a new notification record
  Future<NotificationRecord> createNotificationRecord({
    required String reminderId,
    required String companyId,
    required String userId,
    required String organizationId,
    required String title,
    String? body,
  }) async {
    try {
      final data = await _supabase
          .from('notification_records')
          .insert({
            'reminder_id': reminderId,
            'company_id': companyId,
            'user_id': userId,
            'organization_id': organizationId,
            'title': title,
            'body': body,
          })
          .select()
          .single();

      return NotificationRecordModel.fromJson(data);
    } on PostgrestException catch (e) {
      throw Exception('Failed to create notification record: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create notification record: $e');
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _supabase
          .from('notification_records')
          .update({
            'is_read': true,
            'read_at': DateTime.now().toIso8601String(),
          })
          .eq('id', notificationId)
          .eq('is_read', false);
    } on PostgrestException catch (e) {
      throw Exception('Failed to mark notification as read: ${e.message}');
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _supabase
          .from('notification_records')
          .update({
            'is_read': true,
            'read_at': DateTime.now().toIso8601String(),
          })
          .eq('is_read', false);
    } on PostgrestException catch (e) {
      throw Exception('Failed to mark all notifications as read: ${e.message}');
    } catch (e) {
      throw Exception('Failed to mark all notifications as read: $e');
    }
  }

  /// Delete notification record
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _supabase
          .from('notification_records')
          .delete()
          .eq('id', notificationId);
    } on PostgrestException catch (e) {
      throw Exception('Failed to delete notification: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  /// Delete all read notifications
  Future<void> deleteAllRead() async {
    try {
      await _supabase
          .from('notification_records')
          .delete()
          .eq('is_read', true);
    } on PostgrestException catch (e) {
      throw Exception('Failed to delete read notifications: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete read notifications: $e');
    }
  }
}
