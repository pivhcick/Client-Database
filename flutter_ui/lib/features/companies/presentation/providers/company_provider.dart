import 'package:flutter/foundation.dart';
import '../../domain/entities/company.dart';
import '../../data/repositories/company_repository.dart';

/// Company provider
///
/// Manages state for companies list with search, filter, and sort functionality.
class CompanyProvider extends ChangeNotifier {
  final CompanyRepository _companyRepository;

  CompanyProvider({
    required CompanyRepository companyRepository,
  }) : _companyRepository = companyRepository;

  List<Company> _companies = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;

  // Filter and sort state
  String _searchQuery = '';
  CompanyStatus? _statusFilter;
  CompanySortField _sortField = CompanySortField.createdAt;
  SortDirection _sortDirection = SortDirection.descending;

  // Getters
  List<Company> get companies => _companies;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  CompanyStatus? get statusFilter => _statusFilter;
  CompanySortField get sortField => _sortField;
  SortDirection get sortDirection => _sortDirection;

  /// Get company statistics
  Map<String, int> get companyStats {
    return {
      'total': _companies.length,
      'real': _companies.where((c) => c.status == CompanyStatus.real).length,
      'potential':
          _companies.where((c) => c.status == CompanyStatus.potential).length,
      'lost': _companies.where((c) => c.status == CompanyStatus.lost).length,
    };
  }

  /// Load all companies
  Future<void> loadCompanies() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      _companies = await _companyRepository.getCompaniesFiltered(
        statusFilter: _statusFilter,
        sortField: _sortField,
        sortDirection: _sortDirection,
      );
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _companies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh companies (pull-to-refresh)
  Future<void> refreshCompanies() async {
    await loadCompanies();
  }

  /// Get company by ID
  Future<Company> getCompanyById(String companyId) async {
    return await _companyRepository.getCompanyById(companyId);
  }

  /// Create new company
  Future<void> createCompany({
    required String name,
    required String phone,
    String? email,
    required String address,
    required CompanyStatus status,
    String? content,
    required String createdByUserId,
  }) async {
    await _companyRepository.createCompany(
      name: name,
      phone: phone,
      email: email,
      address: address,
      status: status,
      content: content,
      createdByUserId: createdByUserId,
    );

    // Reload companies after creation
    await loadCompanies();
  }

  /// Update company
  Future<void> updateCompany({
    required String companyId,
    String? name,
    String? phone,
    String? email,
    String? address,
    CompanyStatus? status,
    String? content,
  }) async {
    await _companyRepository.updateCompany(
      companyId: companyId,
      name: name,
      phone: phone,
      email: email,
      address: address,
      status: status,
      content: content,
    );

    // Reload companies after update
    await loadCompanies();
  }

  /// Delete company
  Future<void> deleteCompany(String companyId) async {
    await _companyRepository.deleteCompany(companyId);

    // Reload companies after deletion
    await loadCompanies();
  }

  /// Search companies with combined filter
  Future<void> searchCompanies(String query) async {
    _searchQuery = query;
    await _applyFilters();
  }

  /// Apply combined search, status filter, and sorting
  Future<void> _applyFilters() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      List<Company> result;

      // If there's a search query, use search
      if (_searchQuery.isNotEmpty) {
        result = await _companyRepository.searchCompanies(_searchQuery);
      } else {
        // Otherwise load all companies
        result = await _companyRepository.getCompaniesFiltered(
          statusFilter: null, // Don't filter in repository
          sortField: _sortField,
          sortDirection: _sortDirection,
        );
      }

      // Apply status filter locally if set
      if (_statusFilter != null) {
        result = result.where((c) => c.status == _statusFilter).toList();
      }

      // Apply sorting locally (important for search results)
      result = _sortCompanies(result);

      _companies = result;
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _companies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sort companies locally based on current sort settings
  List<Company> _sortCompanies(List<Company> companies) {
    final sorted = List<Company>.from(companies);

    sorted.sort((a, b) {
      int comparison;

      switch (_sortField) {
        case CompanySortField.name:
          comparison = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case CompanySortField.lastContactDate:
          // Handle null last_contact_date
          if (a.lastContactDate == null && b.lastContactDate == null) {
            comparison = 0;
          } else if (a.lastContactDate == null) {
            comparison = 1; // null values go to the end
          } else if (b.lastContactDate == null) {
            comparison = -1;
          } else {
            comparison = a.lastContactDate!.compareTo(b.lastContactDate!);
          }
          break;
        case CompanySortField.createdAt:
          comparison = a.createdAt.compareTo(b.createdAt);
          break;
      }

      // Apply sort direction
      return _sortDirection == SortDirection.ascending ? comparison : -comparison;
    });

    return sorted;
  }

  /// Set status filter and reapply filters
  void setStatusFilter(CompanyStatus? status) {
    _statusFilter = status;
    _applyFilters();
  }

  /// Clear status filter and reapply filters
  void clearStatusFilter() {
    _statusFilter = null;
    _applyFilters();
  }

  /// Set sort field and direction, then reapply filters
  void setSorting(CompanySortField field, SortDirection direction) {
    _sortField = field;
    _sortDirection = direction;
    _applyFilters();
  }

  /// Toggle sort direction for current field
  void toggleSortDirection() {
    _sortDirection = _sortDirection == SortDirection.ascending
        ? SortDirection.descending
        : SortDirection.ascending;
    _applyFilters();
  }
}
