import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_status.dart';
import '../models/reminder_model.dart';

/// Reminder repository
///
/// Handles all data operations for reminders.
class ReminderRepository {
  final SupabaseClient _supabase;

  ReminderRepository({
    required SupabaseClient supabase,
  }) : _supabase = supabase;

  /// Format DateTime to ISO8601 string with timezone offset
  ///
  /// toIso8601String() doesn't include offset for local time, which causes
  /// PostgreSQL to interpret the time as UTC. This helper ensures the timezone
  /// offset is always included.
  String _formatDateTimeWithTimezone(DateTime dateTime) {
    if (dateTime.isUtc) {
      return dateTime.toIso8601String();
    }

    // Format: 2025-12-12T13:31:00.000+03:00
    final offset = dateTime.timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final sign = offset.isNegative ? '-' : '+';

    final year = dateTime.year.toString();
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    final millisecond = dateTime.millisecond.toString().padLeft(3, '0');

    return '$year-$month-${day}T$hour:$minute:$second.$millisecond$sign$hours:$minutes';
  }

  /// Get all reminders for a user
  ///
  /// Returns reminders ordered by scheduled_for ascending (earliest first).
  /// Includes denormalized company name from JOIN.
  Future<List<Reminder>> getAllReminders(String userId) async {
    try {
      final response = await _supabase
          .from('reminders')
          .select('*, companies(name)')
          .eq('created_by_user_id', userId)
          .order('scheduled_for', ascending: true);

      final reminders = (response as List)
          .map((json) => ReminderModel.fromJson(json).toEntity())
          .toList();

      return reminders;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки напоминаний: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки напоминаний: $e');
    }
  }

  /// Get reminders for a company
  ///
  /// Returns reminders for a specific company ordered by scheduled_for descending (newest first).
  Future<List<Reminder>> getByCompanyId(String companyId) async {
    try {
      final response = await _supabase
          .from('reminders')
          .select('*, companies(name)')
          .eq('company_id', companyId)
          .order('scheduled_for', ascending: false);

      final reminders = (response as List)
          .map((json) => ReminderModel.fromJson(json).toEntity())
          .toList();

      return reminders;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки напоминаний: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки напоминаний: $e');
    }
  }

  /// Create new reminder
  Future<Reminder> createReminder({
    required String companyId,
    required String title,
    String? description,
    required DateTime scheduledFor,
    required String createdByUserId,
  }) async {
    try {
      // Convert to ISO8601 with timezone offset
      final scheduledForString = _formatDateTimeWithTimezone(scheduledFor);

      print('🔍 ReminderRepository.createReminder DEBUG:');
      print('  Input scheduledFor DateTime: $scheduledFor');
      print('  Input scheduledFor isUtc: ${scheduledFor.isUtc}');
      print('  Input scheduledFor timezone offset: ${scheduledFor.timeZoneOffset}');
      print('  Formatted with TZ offset: "$scheduledForString"');

      final response = await _supabase.from('reminders').insert({
        'company_id': companyId,
        'title': title,
        'description': description,
        'scheduled_for': scheduledForString,
        'status': 'pending',
        'created_by_user_id': createdByUserId,
      }).select('*, companies(name)').single();

      final reminderModel = ReminderModel.fromJson(response);
      return reminderModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка создания напоминания: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка создания напоминания: $e');
    }
  }

  /// Update reminder
  Future<Reminder> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? scheduledFor,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (title != null) updates['title'] = title;
      if (description != null) updates['description'] = description;
      if (scheduledFor != null) {
        updates['scheduled_for'] = _formatDateTimeWithTimezone(scheduledFor);
      }

      if (updates.isEmpty) {
        throw Exception('Нет данных для обновления');
      }

      final response = await _supabase
          .from('reminders')
          .update(updates)
          .eq('id', reminderId)
          .select('*, companies(name)')
          .single();

      final reminderModel = ReminderModel.fromJson(response);
      return reminderModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка обновления напоминания: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления напоминания: $e');
    }
  }

  /// Update reminder status
  Future<Reminder> updateReminderStatus({
    required String reminderId,
    required ReminderStatus status,
  }) async {
    try {
      final response = await _supabase
          .from('reminders')
          .update({'status': status.toString()})
          .eq('id', reminderId)
          .select('*, companies(name)')
          .single();

      final reminderModel = ReminderModel.fromJson(response);
      return reminderModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка обновления статуса напоминания: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления статуса напоминания: $e');
    }
  }

  /// Delete reminder
  Future<void> deleteReminder(String reminderId) async {
    try {
      await _supabase.from('reminders').delete().eq('id', reminderId);
    } on PostgrestException catch (e) {
      throw Exception('Ошибка удаления напоминания: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка удаления напоминания: $e');
    }
  }

  /// Update expired reminders status using database RPC function
  ///
  /// Calls the PostgreSQL function that automatically updates all expired
  /// pending reminders to delivered status. Returns the number of updated reminders.
  Future<int> updateExpiredRemindersInDatabase() async {
    try {
      print('📞 Calling update_expired_reminders_rpc()...');
      final response = await _supabase.rpc('update_expired_reminders_rpc');

      // RPC returns a list with one row containing the count
      // Format: [{"updated_count": 5}]
      int updatedCount = 0;
      if (response is List && response.isNotEmpty) {
        final firstRow = response[0];
        if (firstRow is Map && firstRow.containsKey('updated_count')) {
          updatedCount = firstRow['updated_count'] as int? ?? 0;
        }
      }

      print('✅ Database updated $updatedCount expired reminders');
      return updatedCount;
    } on PostgrestException catch (e) {
      print('❌ Error calling update_expired_reminders_rpc: ${e.message}');
      throw Exception('Ошибка обновления просроченных напоминаний: ${e.message}');
    } catch (e) {
      print('❌ Error calling update_expired_reminders_rpc: $e');
      throw Exception('Ошибка обновления просроченных напоминаний: $e');
    }
  }
}
