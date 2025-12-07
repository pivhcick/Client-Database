import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../../auth/domain/entities/user.dart' as entities;
import '../../../auth/data/models/user_model.dart';

/// User repository for CRUD operations
///
/// Handles user management operations (admin only).
/// Different from AuthRepository which handles authentication.
class UserRepository {
  final SupabaseClient _supabase;
  final String _organizationId;

  UserRepository({
    required SupabaseClient supabase,
    required String organizationId,
  })  : _supabase = supabase,
        _organizationId = organizationId;

  /// Get all users in the organization
  Future<List<entities.User>> getAllUsers() async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('organization_id', _organizationId)
          .order('created_at', ascending: false);

      final users = (response as List)
          .map((json) => UserModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();

      return users;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки пользователей: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки пользователей: ${e.toString()}');
    }
  }

  /// Get user by ID
  Future<entities.User> getUserById(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .eq('organization_id', _organizationId)
          .single();

      final userModel = UserModel.fromJson(response);
      return userModel.toEntity();
    } on PostgrestException catch (e) {
      throw Exception('Ошибка загрузки пользователя: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка загрузки пользователя: ${e.toString()}');
    }
  }

  /// Create new user
  ///
  /// Only admin can create users.
  /// Password is hashed with SHA-256.
  Future<entities.User> createUser({
    required String phone,
    required String firstName,
    required String lastName,
    required String middleName,
    required String email,
    required entities.UserRole role,
    required String password,
  }) async {
    try {
      // Hash password with SHA-256
      final passwordHash = sha256.convert(utf8.encode(password)).toString();

      final data = {
        'phone': phone,
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        'email': email,
        'role': role.value,
        'organization_id': _organizationId,
        'password_hash': passwordHash,
      };

      final response = await _supabase
          .from('users')
          .insert(data)
          .select()
          .single();

      final userModel = UserModel.fromJson(response);
      return userModel.toEntity();
    } on PostgrestException catch (e) {
      // Check for unique constraint violations
      if (e.code == '23505') {
        if (e.message.contains('phone')) {
          throw Exception('Пользователь с таким номером телефона уже существует');
        }
        if (e.message.contains('email')) {
          throw Exception('Пользователь с таким email уже существует');
        }
      }
      throw Exception('Ошибка создания пользователя: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка создания пользователя: ${e.toString()}');
    }
  }

  /// Update user
  ///
  /// Only admin can update users.
  /// Password update is optional.
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
    try {
      final updates = <String, dynamic>{};

      if (phone != null) updates['phone'] = phone;
      if (firstName != null) updates['first_name'] = firstName;
      if (lastName != null) updates['last_name'] = lastName;
      if (middleName != null) updates['middle_name'] = middleName;
      if (email != null) updates['email'] = email;
      if (role != null) updates['role'] = role.value;

      // Update password if provided
      if (newPassword != null && newPassword.isNotEmpty) {
        final passwordHash = sha256.convert(utf8.encode(newPassword)).toString();
        updates['password_hash'] = passwordHash;
      }

      if (updates.isEmpty) {
        throw Exception('Нет данных для обновления');
      }

      final response = await _supabase
          .from('users')
          .update(updates)
          .eq('id', userId)
          .eq('organization_id', _organizationId)
          .select()
          .single();

      final userModel = UserModel.fromJson(response);
      return userModel.toEntity();
    } on PostgrestException catch (e) {
      // Check for unique constraint violations
      if (e.code == '23505') {
        if (e.message.contains('phone')) {
          throw Exception('Пользователь с таким номером телефона уже существует');
        }
        if (e.message.contains('email')) {
          throw Exception('Пользователь с таким email уже существует');
        }
      }
      throw Exception('Ошибка обновления пользователя: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка обновления пользователя: ${e.toString()}');
    }
  }

  /// Delete user
  ///
  /// Only admin can delete users.
  /// Cannot delete yourself.
  Future<void> deleteUser(String userId, String currentUserId) async {
    try {
      // Prevent self-deletion
      if (userId == currentUserId) {
        throw Exception('Невозможно удалить свой собственный аккаунт');
      }

      await _supabase
          .from('users')
          .delete()
          .eq('id', userId)
          .eq('organization_id', _organizationId);
    } on PostgrestException catch (e) {
      throw Exception('Ошибка удаления пользователя: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка удаления пользователя: ${e.toString()}');
    }
  }

  /// Search users by name or phone
  Future<List<entities.User>> searchUsers(String query) async {
    try {
      if (query.isEmpty) {
        return getAllUsers();
      }

      final response = await _supabase
          .from('users')
          .select()
          .eq('organization_id', _organizationId)
          .or(
            'first_name.ilike.%$query%,last_name.ilike.%$query%,middle_name.ilike.%$query%,phone.ilike.%$query%',
          )
          .order('created_at', ascending: false);

      final users = (response as List)
          .map((json) => UserModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();

      return users;
    } on PostgrestException catch (e) {
      throw Exception('Ошибка поиска пользователей: ${e.message}');
    } catch (e) {
      throw Exception('Ошибка поиска пользователей: ${e.toString()}');
    }
  }

  /// Get users count by role
  Future<Map<String, int>> getUsersCountByRole() async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('organization_id', _organizationId);

      final users = (response as List)
          .map((json) => UserModel.fromJson(json))
          .toList();

      final admins = users.where((u) => u.role == entities.UserRole.admin).length;
      final regular = users.where((u) => u.role == entities.UserRole.regular).length;

      return {
        'admin': admins,
        'regular': regular,
        'total': users.length,
      };
    } catch (e) {
      return {'admin': 0, 'regular': 0, 'total': 0};
    }
  }
}
