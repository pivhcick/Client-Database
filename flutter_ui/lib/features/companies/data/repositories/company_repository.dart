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
      final response = await _supabase.rpc(
        'get_companies',
        params: {'org_id': _organizationId},
      );

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
      final response = await _supabase.rpc(
        'get_company_by_id',
        params: {
          'comp_id': companyId,
          'org_id': _organizationId,
        },
      );

      if (response == null || (response as List).isEmpty) {
        throw Exception('Компания не найдена');
      }

      final companyModel = CompanyModel.fromJson((response as List).first);
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
      final response = await _supabase.rpc(
        'create_company',
        params: {
          'comp_name': name,
          'comp_phone': phone,
          'comp_email': email,
          'comp_address': address,
          'comp_status': status.value,
          'comp_content': content,
          'org_id': _organizationId,
          'user_id': createdByUserId,
        },
      );

      if (response == null || (response as List).isEmpty) {
        throw Exception('Не удалось создать компанию');
      }

      final companyModel = CompanyModel.fromJson((response as List).first);
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
      final response = await _supabase.rpc(
        'update_company',
        params: {
          'comp_id': companyId,
          'org_id': _organizationId,
          'comp_name': name,
          'comp_phone': phone,
          'comp_email': email,
          'comp_address': address,
          'comp_status': status?.value,
          'comp_content': content,
        },
      );

      if (response == null || (response as List).isEmpty) {
        throw Exception('Не удалось обновить компанию');
      }

      final companyModel = CompanyModel.fromJson((response as List).first);
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
      final response = await _supabase.rpc(
        'delete_company',
        params: {
          'comp_id': companyId,
          'org_id': _organizationId,
        },
      );

      if (response == false) {
        throw Exception('Компания не найдена или не удалена');
      }
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
      final response = await _supabase.rpc(
        'search_companies',
        params: {
          'org_id': _organizationId,
          'search_query': query,
        },
      );

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
      // Map sort field to column name
      String sortFieldName;
      switch (sortField) {
        case CompanySortField.name:
          sortFieldName = 'name';
          break;
        case CompanySortField.lastContactDate:
          sortFieldName = 'last_contact_date';
          break;
        case CompanySortField.createdAt:
          sortFieldName = 'created_at';
          break;
      }

      // Map sort direction
      String sortDir = sortDirection == SortDirection.ascending ? 'asc' : 'desc';

      final response = await _supabase.rpc(
        'get_companies_filtered',
        params: {
          'org_id': _organizationId,
          'status_filter': statusFilter?.value,
          'sort_field': sortFieldName,
          'sort_direction': sortDir,
        },
      );

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
      // Use getAllCompanies and count on client side
      final companies = await getAllCompanies();

      final stats = <String, int>{
        'total': companies.length,
        'real': companies.where((c) => c.status == CompanyStatus.real).length,
        'potential':
            companies.where((c) => c.status == CompanyStatus.potential).length,
        'lost': companies.where((c) => c.status == CompanyStatus.lost).length,
      };

      return stats;
    } catch (e) {
      throw Exception('Ошибка получения статистики: $e');
    }
  }
}
