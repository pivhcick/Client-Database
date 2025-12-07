import 'package:supabase_flutter/supabase_flutter.dart';
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
      final response = await _supabase.rpc(
        'get_users',
        params: {'org_id': _organizationId},
      );

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
      final response = await _supabase.rpc(
        'get_user_by_id_admin',
        params: {
          'user_id': userId,
          'org_id': _organizationId,
        },
      );

      if (response == null || (response as List).isEmpty) {
        throw Exception('Пользователь не найден');
      }

      final userModel = UserModel.fromJson((response as List).first);
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
      final response = await _supabase.rpc(
        'create_user_admin',
        params: {
          'user_phone': phone,
          'user_first_name': firstName,
          'user_last_name': lastName,
          'user_middle_name': middleName,
          'user_email': email,
          'user_password': password,
          'user_role': role.value,
          'org_id': _organizationId,
        },
      );

      if (response == null || (response as List).isEmpty) {
        throw Exception('Не удалось создать пользователя');
      }

      final userModel = UserModel.fromJson((response as List).first);
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
  /// Password update is not supported through this method (security).
  Future<entities.User> updateUser({
    required String userId,
    String? phone,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    entities.UserRole? role,
    String? newPassword, // Deprecated - not used
  }) async {
    try {
      final response = await _supabase.rpc(
        'update_user_admin',
        params: {
          'user_id': userId,
          'org_id': _organizationId,
          'user_first_name': firstName,
          'user_last_name': lastName,
          'user_middle_name': middleName,
          'user_email': email,
          'user_role': role?.value,
        },
      );

      if (response == null || (response as List).isEmpty) {
        throw Exception('Не удалось обновить пользователя');
      }

      final userModel = UserModel.fromJson((response as List).first);
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

      final response = await _supabase.rpc(
        'delete_user_admin',
        params: {
          'user_id': userId,
          'org_id': _organizationId,
        },
      );

      if (response == false) {
        throw Exception('Пользователь не найден или не удален');
      }
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

      final response = await _supabase.rpc(
        'search_users',
        params: {
          'org_id': _organizationId,
          'search_query': query,
        },
      );

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
