import 'package:flutter/foundation.dart';
import '../../../auth/domain/entities/user.dart' as entities;
import '../../data/repositories/user_repository.dart';

/// User provider (ChangeNotifier)
///
/// Manages user list state and provides CRUD methods to UI.
/// Only accessible to admin users.
class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;

  UserProvider({required UserRepository userRepository})
      : _userRepository = userRepository;

  // State
  List<entities.User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, int> _userStats = {'admin': 0, 'regular': 0, 'total': 0};

  // Getters
  List<entities.User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, int> get userStats => _userStats;
  bool get hasError => _errorMessage != null;

  /// Load all users
  Future<void> loadUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _users = await _userRepository.getAllUsers();
      _userStats = await _userRepository.getUsersCountByRole();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Search users
  Future<void> searchUsers(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _users = await _userRepository.searchUsers(query);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Create new user
  Future<entities.User> createUser({
    required String phone,
    required String firstName,
    required String lastName,
    required String middleName,
    required String email,
    required entities.UserRole role,
    required String password,
  }) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final newUser = await _userRepository.createUser(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: email,
        role: role,
        password: password,
      );

      // Reload users list
      await loadUsers();

      return newUser;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Update user
  Future<entities.User> updateUser({
    required String userId,
    String? phone,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    entities.UserRole? role,
    String? newPassword,
  }) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedUser = await _userRepository.updateUser(
        userId: userId,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: email,
        role: role,
        newPassword: newPassword,
      );

      // Reload users list
      await loadUsers();

      return updatedUser;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Delete user
  Future<void> deleteUser(String userId, String currentUserId) async {
    _errorMessage = null;
    notifyListeners();

    try {
      await _userRepository.deleteUser(userId, currentUserId);

      // Reload users list
      await loadUsers();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Get user by ID
  Future<entities.User> getUserById(String userId) async {
    try {
      return await _userRepository.getUserById(userId);
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Refresh users list (pull-to-refresh)
  Future<void> refreshUsers() async {
    await loadUsers();
  }
}
