import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_status.dart';

/// Reminder model for JSON serialization
///
/// Handles conversion between Supabase JSON and Reminder entity.
class ReminderModel {
  final String id;
  final String companyId;
  final String title;
  final String? description;
  final DateTime scheduledFor;
  final ReminderStatus status;
  final String createdByUserId;
  final String? companyName;

  const ReminderModel({
    required this.id,
    required this.companyId,
    required this.title,
    this.description,
    required this.scheduledFor,
    required this.status,
    required this.createdByUserId,
    this.companyName,
  });

  /// Create model from JSON
  ///
  /// When fetching from Supabase with JOIN to companies table, JSON should contain:
  /// - name from companies table
  /// This is used as companyName
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    // Extract company name from joined companies table data
    String? companyName;
    if (json['companies'] != null) {
      final company = json['companies'] as Map<String, dynamic>;
      companyName = company['name'] as String?;
    }

    return ReminderModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      scheduledFor: DateTime.parse(json['scheduled_for'] as String),
      status: ReminderStatus.fromString(json['status'] as String),
      createdByUserId: json['created_by_user_id'] as String,
      companyName: companyName,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'title': title,
      'description': description,
      'scheduled_for': scheduledFor.toIso8601String(),
      'status': status.toString(),
      'created_by_user_id': createdByUserId,
    };
  }

  /// Convert model to entity
  Reminder toEntity() {
    return Reminder(
      id: id,
      companyId: companyId,
      title: title,
      description: description,
      scheduledFor: scheduledFor,
      status: status,
      createdByUserId: createdByUserId,
      companyName: companyName,
    );
  }

  /// Create model from entity
  factory ReminderModel.fromEntity(Reminder entity) {
    return ReminderModel(
      id: entity.id,
      companyId: entity.companyId,
      title: entity.title,
      description: entity.description,
      scheduledFor: entity.scheduledFor,
      status: entity.status,
      createdByUserId: entity.createdByUserId,
      companyName: entity.companyName,
    );
  }
}
