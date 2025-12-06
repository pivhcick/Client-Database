import '../../domain/entities/organization.dart';

/// Organization model (data layer)
///
/// Handles JSON serialization/deserialization for Supabase API.
class OrganizationModel extends Organization {
  const OrganizationModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  /// Create model from JSON (from Supabase)
  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Convert model to JSON (for Supabase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create model from entity
  factory OrganizationModel.fromEntity(Organization entity) {
    return OrganizationModel(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
    );
  }

  /// Convert model to entity
  Organization toEntity() {
    return Organization(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }

  /// Create a copy with modified fields
  OrganizationModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return OrganizationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
