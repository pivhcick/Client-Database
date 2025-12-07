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

  /// Search companies
  Future<void> searchCompanies(String query) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      _companies = await _companyRepository.searchCompanies(query);
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

  /// Set status filter
  void setStatusFilter(CompanyStatus? status) {
    _statusFilter = status;
    loadCompanies();
  }

  /// Clear status filter
  void clearStatusFilter() {
    _statusFilter = null;
    loadCompanies();
  }

  /// Set sort field and direction
  void setSorting(CompanySortField field, SortDirection direction) {
    _sortField = field;
    _sortDirection = direction;
    loadCompanies();
  }

  /// Toggle sort direction for current field
  void toggleSortDirection() {
    _sortDirection = _sortDirection == SortDirection.ascending
        ? SortDirection.descending
        : SortDirection.ascending;
    loadCompanies();
  }
}
