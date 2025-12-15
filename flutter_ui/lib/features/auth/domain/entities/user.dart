/// User roles enumeration
enum UserRole {
  admin('admin'),
  regular('regular');

  final String value;
  const UserRole(this.value);

  /// Get display name in Russian
  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Администратор';
      case UserRole.regular:
        return 'Пользователь';
    }
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.regular,
    );
  }
}

/// User entity (domain layer)
///
/// Represents a user in the system.
/// Users belong to an organization and have a role (admin or regular).
class User {
  final String id;
  final String phone;
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final UserRole role;
  final String organizationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.email,
    required this.role,
    required this.organizationId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get full name in Russian format: Фамилия Имя Отчество
  String get fullName => '$lastName $firstName $middleName';

  /// Check if user is admin
  bool get isAdmin => role == UserRole.admin;

  /// Check if user is regular user
  bool get isRegular => role == UserRole.regular;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'User(id: $id, fullName: $fullName, role: ${role.value}, organizationId: $organizationId)';
}
