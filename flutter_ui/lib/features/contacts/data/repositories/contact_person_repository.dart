import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/contact_person.dart';
import '../models/contact_person_model.dart';

/// Contact person repository
///
/// Handles all data operations for contact persons.
class ContactPersonRepository {
  final SupabaseClient _supabase;

  ContactPersonRepository({
    required SupabaseClient supabase,
  }) : _supabase = supabase;

  /// Get all contact persons for a company
  Future<List<ContactPerson>> getByCompanyId(String companyId) async {
    try {
      final response = await _supabase
          .from('contact_persons')
          .select()
          .eq('company_id', companyId)
          .order('last_name', ascending: true);

      final contactPersons = (response as List)
          .map((json) => ContactPersonModel.fromJson(json).toEntity())
          .toList();

      return contactPersons;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки контактных лиц: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки контактных лиц: $e');
    }
  }

  /// Create new contact person
  Future<ContactPerson> createContactPerson({
    required String companyId,
    required String firstName,
    required String lastName,
    required String middleName,
    required String position,
    required String phone,
    String? email,
  }) async {
    try {
      final response = await _supabase.from('contact_persons').insert({
        'company_id': companyId,
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        'position': position,
        'phone': phone,
        'email': email,
      }).select().single();

      final contactPersonModel = ContactPersonModel.fromJson(response);
      return contactPersonModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка создания контактного лица: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка создания контактного лица: $e');
    }
  }

  /// Update contact person
  Future<ContactPerson> updateContactPerson({
    required String contactPersonId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? position,
    String? phone,
    String? email,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (firstName != null) updates['first_name'] = firstName;
      if (lastName != null) updates['last_name'] = lastName;
      if (middleName != null) updates['middle_name'] = middleName;
      if (position != null) updates['position'] = position;
      if (phone != null) updates['phone'] = phone;
      if (email != null) updates['email'] = email;

      if (updates.isEmpty) {
        throw Exception('Нет данных для обновления');
      }

      final response = await _supabase
          .from('contact_persons')
          .update(updates)
          .eq('id', contactPersonId)
          .select()
          .single();

      final contactPersonModel = ContactPersonModel.fromJson(response);
      return contactPersonModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка обновления контактного лица: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления контактного лица: $e');
    }
  }

  /// Delete contact person
  Future<void> deleteContactPerson(String contactPersonId) async {
    try {
      await _supabase
          .from('contact_persons')
          .delete()
          .eq('id', contactPersonId);
    } on PostgrestException catch (e) {
      throw Exception('Ошибка удаления контактного лица: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка удаления контактного лица: $e');
    }
  }
}
