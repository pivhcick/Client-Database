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
  /// Returns reminders for a specific company ordered by scheduled_for ascending.
  Future<List<Reminder>> getByCompanyId(String companyId) async {
    try {
      final response = await _supabase
          .from('reminders')
          .select('*, companies(name)')
          .eq('company_id', companyId)
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

  /// Create new reminder
  Future<Reminder> createReminder({
    required String companyId,
    required String title,
    String? description,
    required DateTime scheduledFor,
    required String createdByUserId,
  }) async {
    try {
      final response = await _supabase.from('reminders').insert({
        'company_id': companyId,
        'title': title,
        'description': description,
        'scheduled_for': scheduledFor.toIso8601String(),
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
        updates['scheduled_for'] = scheduledFor.toIso8601String();
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
}
