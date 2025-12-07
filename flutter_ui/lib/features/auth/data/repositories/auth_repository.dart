import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/user.dart' as entities;
import '../../domain/entities/organization.dart' as entities;
import '../models/user_model.dart';
import '../models/organization_model.dart';

/// Authentication repository
///
/// Handles all authentication operations with Supabase:
/// - Login/logout
/// - User session management
/// - Token storage
/// - Password reset
class AuthRepository {
  final SupabaseClient _supabase;
  final SecureStorage _secureStorage;

  AuthRepository({
    required SupabaseClient supabase,
    required SecureStorage secureStorage,
  })  : _supabase = supabase,
        _secureStorage = secureStorage;

  /// Login with phone and password
  ///
  /// Returns User on success, throws exception on failure.
  Future<entities.User> login({
    required String phone,
    required String password,
  }) async {
    try {
      // Call RPC function to authenticate
      final authResponse = await _supabase.rpc(
        'authenticate_user',
        params: {
          'user_phone': phone,
          'user_password': password,
        },
      );

      // Check if authentication was successful
      if (authResponse == null || authResponse['success'] != true) {
        final message = authResponse?['message'] ?? 'Ошибка авторизации';
        throw Exception(message);
      }

      // Extract user data from response
      final userData = authResponse['user'];
      if (userData == null) {
        throw Exception('Ошибка получения данных пользователя');
      }

      // Add organization data to user object for model parsing
      if (authResponse['organization'] != null) {
        userData['organizations'] = authResponse['organization'];
      }

      // Create user model
      final userModel = UserModel.fromJson(userData);

      // Store user credentials in secure storage
      await _secureStorage.saveUserId(userModel.id);
      await _secureStorage.saveOrganizationId(userModel.organizationId);

      // Store token
      if (authResponse['token'] != null) {
        await _secureStorage.saveAccessToken(authResponse['token']);
      }

      return userModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка входа: ${e.message}');
    } catch (e) {
      // Extract error message if it's an Exception
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      throw Exception('Ошибка входа: $errorMessage');
    }
  }

  /// Get current authenticated user
  ///
  /// Returns User if authenticated, null otherwise.
  Future<entities.User?> getCurrentUser() async {
    try {
      // Check if we have stored user ID
      final userId = await _secureStorage.getUserId();
      if (userId == null) return null;

      // Fetch user from Supabase using RPC function
      final response = await _supabase.rpc(
        'get_user_by_id',
        params: {'user_id': userId},
      );

      if (response == null) return null;

      final userModel = UserModel.fromJson(response);
      return userModel.toEntity();
    } catch (e) {
      // If error, user is not authenticated
      return null;
    }
  }

  /// Get organization for current user
  Future<entities.Organization?> getCurrentOrganization() async {
    try {
      final organizationId = await _secureStorage.getOrganizationId();
      if (organizationId == null) return null;

      final response = await _supabase
          .from('organizations')
          .select()
          .eq('id', organizationId)
          .single();

      final orgModel = OrganizationModel.fromJson(response);
      return orgModel.toEntity();
    } catch (e) {
      return null;
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _secureStorage.hasAccessToken();
  }

  /// Logout
  Future<void> logout() async {
    await _secureStorage.clearAll();
  }

  /// Request password reset
  ///
  /// Sends password reset instructions to user's phone/email.
  Future<void> requestPasswordReset(String phone) async {
    try {
      // Call Supabase function to initiate password reset
      // This would typically send an SMS or email
      await _supabase.rpc(
        'request_password_reset',
        params: {'user_phone': phone},
      );
    } on PostgrestException catch (e) {
      throw Exception('Ошибка сброса пароля: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка сброса пароля: ${e.toString()}');
    }
  }

  /// Reset password with verification code
  ///
  /// Used after user receives reset code via SMS/email.
  Future<void> resetPassword({
    required String phone,
    required String verificationCode,
    required String newPassword,
  }) async {
    try {
      await _supabase.rpc(
        'reset_password_with_code',
        params: {
          'user_phone': phone,
          'verification_code': verificationCode,
          'new_password': newPassword,
        },
      );
    } on PostgrestException catch (e) {
      throw Exception('Ошибка смены пароля: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка смены пароля: ${e.toString()}');
    }
  }

  /// Update user profile
  Future<entities.User> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (firstName != null) updates['first_name'] = firstName;
      if (lastName != null) updates['last_name'] = lastName;
      if (middleName != null) updates['middle_name'] = middleName;
      if (email != null) updates['email'] = email;

      final response = await _supabase
          .from('users')
          .update(updates)
          .eq('id', userId)
          .select()
          .single();

      final userModel = UserModel.fromJson(response);
      return userModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка обновления профиля: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления профиля: ${e.toString()}');
    }
  }
}
