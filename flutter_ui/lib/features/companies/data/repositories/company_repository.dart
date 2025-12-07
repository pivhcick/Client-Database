import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/company.dart';
import '../models/company_model.dart';

/// Sort field for companies
enum CompanySortField {
  name,
  lastContactDate,
  createdAt,
}

/// Sort direction
enum SortDirection {
  ascending,
  descending,
}

/// Company repository
///
/// Handles all data operations for companies with automatic organization_id filtering.
class CompanyRepository {
  final SupabaseClient _supabase;
  final String _organizationId;

  CompanyRepository({
    required SupabaseClient supabase,
    required String organizationId,
  })  : _supabase = supabase,
        _organizationId = organizationId;

  /// Get all companies in the organization
  Future<List<Company>> getAllCompanies() async {
    try {
      final response = await _supabase
          .from('companies')
          .select()
          .eq('organization_id', _organizationId)
          .order('created_at', ascending: false);

      final companies = (response as List)
          .map((json) => CompanyModel.fromJson(json).toEntity())
          .toList();

      return companies;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки компаний: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки компаний: $e');
    }
  }

  /// Get company by ID
  Future<Company> getCompanyById(String companyId) async {
    try {
      final response = await _supabase
          .from('companies')
          .select()
          .eq('id', companyId)
          .eq('organization_id', _organizationId)
          .single();

      final companyModel = CompanyModel.fromJson(response);
      return companyModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Компания не найдена: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки компании: $e');
    }
  }

  /// Create new company
  Future<Company> createCompany({
    required String name,
    required String phone,
    String? email,
    required String address,
    required CompanyStatus status,
    String? content,
    required String createdByUserId,
  }) async {
    try {
      final data = {
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        'status': status.value,
        'content': content,
        'organization_id': _organizationId,
        'created_by_user_id': createdByUserId,
      };

      final response =
          await _supabase.from('companies').insert(data).select().single();

      final companyModel = CompanyModel.fromJson(response);
      return companyModel.toEntity();
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        if (e.message.contains('phone')) {
          throw Exception('Компания с таким номером телефона уже существует');
        }
      }
      throw Exception('Ошибка создания компании: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка создания компании: $e');
    }
  }

  /// Update company
  Future<Company> updateCompany({
    required String companyId,
    String? name,
    String? phone,
    String? email,
    String? address,
    CompanyStatus? status,
    String? content,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (name != null) data['name'] = name;
      if (phone != null) data['phone'] = phone;
      if (email != null) data['email'] = email;
      if (address != null) data['address'] = address;
      if (status != null) data['status'] = status.value;
      if (content != null) data['content'] = content;

      if (data.isEmpty) {
        throw Exception('Нет данных для обновления');
      }

      final response = await _supabase
          .from('companies')
          .update(data)
          .eq('id', companyId)
          .eq('organization_id', _organizationId)
          .select()
          .single();

      final companyModel = CompanyModel.fromJson(response);
      return companyModel.toEntity();
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        if (e.message.contains('phone')) {
          throw Exception('Компания с таким номером телефона уже существует');
        }
      }
      throw Exception('Ошибка обновления компании: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления компании: $e');
    }
  }

  /// Delete company
  Future<void> deleteCompany(String companyId) async {
    try {
      await _supabase
          .from('companies')
          .delete()
          .eq('id', companyId)
          .eq('organization_id', _organizationId);
    } on PostgrestException catch (e) {
      throw Exception('Ошибка удаления компании: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка удаления компании: $e');
    }
  }

  /// Search companies by name, phone, or address
  Future<List<Company>> searchCompanies(String query) async {
    if (query.isEmpty) {
      return getAllCompanies();
    }

    try {
      // Search in name, phone, and address fields
      final response = await _supabase
          .from('companies')
          .select()
          .eq('organization_id', _organizationId)
          .or('name.ilike.%$query%,phone.ilike.%$query%,address.ilike.%$query%')
          .order('created_at', ascending: false);

      final companies = (response as List)
          .map((json) => CompanyModel.fromJson(json).toEntity())
          .toList();

      return companies;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка поиска компаний: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка поиска компаний: $e');
    }
  }

  /// Get companies with filters and sorting
  Future<List<Company>> getCompaniesFiltered({
    CompanyStatus? statusFilter,
    CompanySortField sortField = CompanySortField.createdAt,
    SortDirection sortDirection = SortDirection.descending,
  }) async {
    try {
      var query =
          _supabase.from('companies').select().eq('organization_id', _organizationId);

      // Apply status filter
      if (statusFilter != null) {
        query = query.eq('status', statusFilter.value);
      }

      // Apply sorting
      String orderColumn;
      switch (sortField) {
        case CompanySortField.name:
          orderColumn = 'name';
          break;
        case CompanySortField.lastContactDate:
          orderColumn = 'last_contact_date';
          break;
        case CompanySortField.createdAt:
          orderColumn = 'created_at';
          break;
      }

      final response = await query.order(orderColumn,
          ascending: sortDirection == SortDirection.ascending);

      final companies = (response as List)
          .map((json) => CompanyModel.fromJson(json).toEntity())
          .toList();

      return companies;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки компаний: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки компаний: $e');
    }
  }

  /// Get statistics: count by status
  Future<Map<String, int>> getCompaniesCountByStatus() async {
    try {
      final response = await _supabase
          .from('companies')
          .select()
          .eq('organization_id', _organizationId);

      final companies = (response as List)
          .map((json) => CompanyModel.fromJson(json).toEntity())
          .toList();

      final stats = <String, int>{
        'total': companies.length,
        'real': companies.where((c) => c.status == CompanyStatus.real).length,
        'potential':
            companies.where((c) => c.status == CompanyStatus.potential).length,
        'lost': companies.where((c) => c.status == CompanyStatus.lost).length,
      };

      return stats;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка получения статистики: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка получения статистики: $e');
    }
  }
}
