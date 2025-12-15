import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/organization.dart';
import '../../data/repositories/auth_repository.dart';

/// Authentication state
enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

/// Authentication provider (ChangeNotifier)
///
/// Manages authentication state and provides auth methods to UI.
/// Notifies listeners when auth state changes.
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // State
  AuthState _state = AuthState.initial;
  User? _currentUser;
  Organization? _currentOrganization;
  String? _errorMessage;

  // Getters
  AuthState get state => _state;
  User? get currentUser => _currentUser;
  Organization? get currentOrganization => _currentOrganization;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;
  bool get hasError => _state == AuthState.error;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  /// Initialize authentication state
  ///
  /// Checks if user is already logged in.
  /// Call this in main.dart during app startup.
  Future<void> initializeAuth() async {
    try {
      _state = AuthState.loading;
      notifyListeners();

      final isAuth = await _authRepository.isAuthenticated();
      if (isAuth) {
        // Fetch current user and organization
        _currentUser = await _authRepository.getCurrentUser();
        _currentOrganization = await _authRepository.getCurrentOrganization();

        if (_currentUser != null) {
          _state = AuthState.authenticated;
        } else {
          _state = AuthState.unauthenticated;
        }
      } else {
        _state = AuthState.unauthenticated;
      }

      notifyListeners();
    } catch (e) {
      _state = AuthState.unauthenticated;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Login with phone and password
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      // Login
      _currentUser = await _authRepository.login(
        phone: phone,
        password: password,
      );

      // Fetch organization
      _currentOrganization = await _authRepository.getCurrentOrganization();

      _state = AuthState.authenticated;
      notifyListeners();
    } on SocketException {
      _state = AuthState.error;
      _errorMessage = 'Нет подключения к интернету. Проверьте сетевое соединение и попробуйте снова.';
      _currentUser = null;
      _currentOrganization = null;
      notifyListeners();
      rethrow;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _currentUser = null;
      _currentOrganization = null;
      notifyListeners();
      rethrow;
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _authRepository.logout();
      _currentUser = null;
      _currentOrganization = null;
      _state = AuthState.unauthenticated;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Request password reset
  Future<void> requestPasswordReset(String phone) async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      await _authRepository.requestPasswordReset(phone);

      _state = AuthState.unauthenticated;
      notifyListeners();
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Reset password with verification code
  Future<void> resetPassword({
    required String phone,
    required String verificationCode,
    required String newPassword,
  }) async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      await _authRepository.resetPassword(
        phone: phone,
        verificationCode: verificationCode,
        newPassword: newPassword,
      );

      _state = AuthState.unauthenticated;
      notifyListeners();
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
  }) async {
    if (_currentUser == null) return;

    try {
      _currentUser = await _authRepository.updateProfile(
        userId: _currentUser!.id,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: email,
      );
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    if (_state == AuthState.error) {
      _state = _currentUser != null
          ? AuthState.authenticated
          : AuthState.unauthenticated;
    }
    notifyListeners();
  }
}
