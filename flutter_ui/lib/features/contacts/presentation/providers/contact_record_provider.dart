import 'package:flutter/foundation.dart';
import '../../domain/entities/contact_record.dart';
import '../../data/repositories/contact_record_repository.dart';

/// Contact record provider
///
/// Manages state for contact records (interaction history) associated with a company.
class ContactRecordProvider extends ChangeNotifier {
  final ContactRecordRepository _repository;

  ContactRecordProvider({
    required ContactRecordRepository repository,
  }) : _repository = repository;

  List<ContactRecord> _contactRecords = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  String? _currentCompanyId;

  // Getters
  List<ContactRecord> get contactRecords => _contactRecords;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  /// Load contact records for a company
  Future<void> loadContactRecords(String companyId) async {
    _currentCompanyId = companyId;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      _contactRecords = await _repository.getByCompanyId(companyId);
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _contactRecords = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh contact records
  Future<void> refreshContactRecords() async {
    if (_currentCompanyId != null) {
      await loadContactRecords(_currentCompanyId!);
    }
  }

  /// Create new contact record
  Future<void> createContactRecord({
    required String companyId,
    required String content,
    required String createdByUserId,
  }) async {
    await _repository.createContactRecord(
      companyId: companyId,
      content: content,
      createdByUserId: createdByUserId,
    );

    // Reload contact records after creation
    await loadContactRecords(companyId);
  }

  /// Update contact record
  Future<void> updateContactRecord({
    required String contactRecordId,
    required String content,
  }) async {
    await _repository.updateContactRecord(
      contactRecordId: contactRecordId,
      content: content,
    );

    // Reload contact records after update
    if (_currentCompanyId != null) {
      await loadContactRecords(_currentCompanyId!);
    }
  }

  /// Delete contact record
  Future<void> deleteContactRecord(String contactRecordId) async {
    await _repository.deleteContactRecord(contactRecordId);

    // Reload contact records after deletion
    if (_currentCompanyId != null) {
      await loadContactRecords(_currentCompanyId!);
    }
  }
}
