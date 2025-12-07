import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/contact_record.dart';
import '../models/contact_record_model.dart';

/// Contact record repository
///
/// Handles all data operations for contact records (interaction history).
class ContactRecordRepository {
  final SupabaseClient _supabase;

  ContactRecordRepository({
    required SupabaseClient supabase,
  }) : _supabase = supabase;

  /// Get all contact records for a company
  ///
  /// Returns records ordered by created_at descending (newest first).
  /// Includes denormalized user name from JOIN.
  Future<List<ContactRecord>> getByCompanyId(String companyId) async {
    try {
      final response = await _supabase
          .from('contact_records')
          .select('*, users(first_name, last_name, middle_name)')
          .eq('company_id', companyId)
          .order('created_at', ascending: false);

      final contactRecords = (response as List)
          .map((json) => ContactRecordModel.fromJson(json).toEntity())
          .toList();

      return contactRecords;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки записей о контактах: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки записей о контактах: $e');
    }
  }

  /// Create new contact record
  ///
  /// This will automatically:
  /// - Set created_at to current timestamp (default in DB)
  /// - Trigger update of last_contact_date in companies table
  Future<ContactRecord> createContactRecord({
    required String companyId,
    required String content,
    required String createdByUserId,
  }) async {
    try {
      final response = await _supabase.from('contact_records').insert({
        'company_id': companyId,
        'content': content,
        'created_by_user_id': createdByUserId,
      }).select('*, users(first_name, last_name, middle_name)').single();

      final contactRecordModel = ContactRecordModel.fromJson(response);
      return contactRecordModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка создания записи о контакте: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка создания записи о контакте: $e');
    }
  }

  /// Update contact record
  ///
  /// Only content can be updated. Created_at and user info are immutable.
  Future<ContactRecord> updateContactRecord({
    required String contactRecordId,
    required String content,
  }) async {
    try {
      final response = await _supabase
          .from('contact_records')
          .update({'content': content})
          .eq('id', contactRecordId)
          .select('*, users(first_name, last_name, middle_name)')
          .single();

      final contactRecordModel = ContactRecordModel.fromJson(response);
      return contactRecordModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка обновления записи о контакте: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления записи о контакте: $e');
    }
  }

  /// Delete contact record
  Future<void> deleteContactRecord(String contactRecordId) async {
    try {
      await _supabase
          .from('contact_records')
          .delete()
          .eq('id', contactRecordId);
    } on PostgrestException catch (e) {
      throw Exception('Ошибка удаления записи о контакте: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка удаления записи о контакте: $e');
    }
  }
}
