import '../../domain/entities/company.dart';

/// Company data model for JSON serialization
///
/// Maps between Supabase JSON and Company entity.
class CompanyModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String address;
  final String status;
  final String? content;
  final DateTime? lastContactDate;
  final String organizationId;
  final String createdByUserId;
  final DateTime createdAt;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.address,
    required this.status,
    this.content,
    this.lastContactDate,
    required this.organizationId,
    required this.createdByUserId,
    required this.createdAt,
  });

  /// Create model from JSON (Supabase response)
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String,
      status: json['status'] as String,
      content: json['content'] as String?,
      lastContactDate: json['last_contact_date'] != null
          ? DateTime.parse(json['last_contact_date'] as String)
          : null,
      organizationId: json['organization_id'] as String,
      createdByUserId: json['created_by_user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Convert model to JSON (for Supabase insert/update)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'status': status,
      'content': content,
      'last_contact_date': lastContactDate?.toIso8601String(),
      'organization_id': organizationId,
      'created_by_user_id': createdByUserId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Convert model to entity
  Company toEntity() {
    return Company(
      id: id,
      name: name,
      phone: phone,
      email: email,
      address: address,
      status: CompanyStatus.fromString(status),
      content: content,
      lastContactDate: lastContactDate,
      organizationId: organizationId,
      createdByUserId: createdByUserId,
      createdAt: createdAt,
    );
  }

  /// Create model from entity
  factory CompanyModel.fromEntity(Company company) {
    return CompanyModel(
      id: company.id,
      name: company.name,
      phone: company.phone,
      email: company.email,
      address: company.address,
      status: company.status.value,
      content: company.content,
      lastContactDate: company.lastContactDate,
      organizationId: company.organizationId,
      createdByUserId: company.createdByUserId,
      createdAt: company.createdAt,
    );
  }
}
