import '../../domain/entities/user.dart';

/// User model (data layer)
///
/// Handles JSON serialization/deserialization for Supabase API.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.phone,
    required super.firstName,
    required super.lastName,
    required super.middleName,
    required super.email,
    required super.role,
    required super.organizationId,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create model from JSON (from Supabase)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      middleName: json['middle_name'] as String,
      email: json['email'] as String,
      role: UserRole.fromString(json['role'] as String),
      organizationId: json['organization_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert model to JSON (for Supabase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'email': email,
      'role': role.value,
      'organization_id': organizationId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create model from entity
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      phone: entity.phone,
      firstName: entity.firstName,
      lastName: entity.lastName,
      middleName: entity.middleName,
      email: entity.email,
      role: entity.role,
      organizationId: entity.organizationId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Convert model to entity
  User toEntity() {
    return User(
      id: id,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      email: email,
      role: role,
      organizationId: organizationId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create a copy with modified fields
  UserModel copyWith({
    String? id,
    String? phone,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    UserRole? role,
    String? organizationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      email: email ?? this.email,
      role: role ?? this.role,
      organizationId: organizationId ?? this.organizationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
