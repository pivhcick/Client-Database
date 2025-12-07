import '../../domain/entities/contact_record.dart';

/// Contact record model for JSON serialization
///
/// Handles conversion between Supabase JSON and ContactRecord entity.
class ContactRecordModel {
  final String id;
  final String companyId;
  final String content;
  final DateTime createdAt;
  final String createdByUserId;
  final String? createdByUserName;

  const ContactRecordModel({
    required this.id,
    required this.companyId,
    required this.content,
    required this.createdAt,
    required this.createdByUserId,
    this.createdByUserName,
  });

  /// Create model from JSON
  ///
  /// When fetching from Supabase with JOIN to users table, JSON should contain:
  /// - first_name, last_name, middle_name from users table
  /// These are combined into createdByUserName
  factory ContactRecordModel.fromJson(Map<String, dynamic> json) {
    // Build user name from joined users table data
    String? userName;
    if (json['users'] != null) {
      final user = json['users'] as Map<String, dynamic>;
      final lastName = user['last_name'] as String? ?? '';
      final firstName = user['first_name'] as String? ?? '';
      final middleName = user['middle_name'] as String? ?? '';

      if (lastName.isNotEmpty || firstName.isNotEmpty) {
        final firstInitial = firstName.isNotEmpty ? firstName[0] : '';
        final middleInitial = middleName.isNotEmpty ? middleName[0] : '';
        userName = '$lastName $firstInitial.$middleInitial.'.trim();
      }
    }

    return ContactRecordModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdByUserId: json['created_by_user_id'] as String,
      createdByUserName: userName,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'created_by_user_id': createdByUserId,
    };
  }

  /// Convert model to entity
  ContactRecord toEntity() {
    return ContactRecord(
      id: id,
      companyId: companyId,
      content: content,
      createdAt: createdAt,
      createdByUserId: createdByUserId,
      createdByUserName: createdByUserName,
    );
  }

  /// Create model from entity
  factory ContactRecordModel.fromEntity(ContactRecord entity) {
    return ContactRecordModel(
      id: entity.id,
      companyId: entity.companyId,
      content: entity.content,
      createdAt: entity.createdAt,
      createdByUserId: entity.createdByUserId,
      createdByUserName: entity.createdByUserName,
    );
  }
}
