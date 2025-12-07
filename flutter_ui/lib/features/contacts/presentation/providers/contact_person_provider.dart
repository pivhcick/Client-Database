import 'package:flutter/foundation.dart';
import '../../domain/entities/contact_person.dart';
import '../../data/repositories/contact_person_repository.dart';

/// Contact person provider
///
/// Manages state for contact persons associated with a company.
class ContactPersonProvider extends ChangeNotifier {
  final ContactPersonRepository _repository;

  ContactPersonProvider({
    required ContactPersonRepository repository,
  }) : _repository = repository;

  List<ContactPerson> _contactPersons = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  String? _currentCompanyId;

  // Getters
  List<ContactPerson> get contactPersons => _contactPersons;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  /// Load contact persons for a company
  Future<void> loadContactPersons(String companyId) async {
    _currentCompanyId = companyId;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      _contactPersons = await _repository.getByCompanyId(companyId);
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _contactPersons = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh contact persons
  Future<void> refreshContactPersons() async {
    if (_currentCompanyId != null) {
      await loadContactPersons(_currentCompanyId!);
    }
  }

  /// Create new contact person
  Future<void> createContactPerson({
    required String companyId,
    required String firstName,
    required String lastName,
    required String middleName,
    required String position,
    required String phone,
    String? email,
  }) async {
    await _repository.createContactPerson(
      companyId: companyId,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      position: position,
      phone: phone,
      email: email,
    );

    // Reload contact persons after creation
    await loadContactPersons(companyId);
  }

  /// Update contact person
  Future<void> updateContactPerson({
    required String contactPersonId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? position,
    String? phone,
    String? email,
  }) async {
    await _repository.updateContactPerson(
      contactPersonId: contactPersonId,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      position: position,
      phone: phone,
      email: email,
    );

    // Reload contact persons after update
    if (_currentCompanyId != null) {
      await loadContactPersons(_currentCompanyId!);
    }
  }

  /// Delete contact person
  Future<void> deleteContactPerson(String contactPersonId) async {
    await _repository.deleteContactPerson(contactPersonId);

    // Reload contact persons after deletion
    if (_currentCompanyId != null) {
      await loadContactPersons(_currentCompanyId!);
    }
  }
}
