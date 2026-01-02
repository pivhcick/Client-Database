import '../../domain/entities/notification_record.dart';

/// Notification record model for Supabase serialization
class NotificationRecordModel extends NotificationRecord {
  const NotificationRecordModel({
    required super.id,
    required super.reminderId,
    required super.companyId,
    required super.userId,
    required super.organizationId,
    required super.title,
    super.body,
    super.companyName,
    required super.deliveredAt,
    required super.isRead,
    super.readAt,
    required super.createdAt,
  });

  /// Create from Supabase JSON
  factory NotificationRecordModel.fromJson(Map<String, dynamic> json) {
    // Extract company name from joined table if available
    String? companyName;
    if (json['companies'] != null && json['companies'] is Map) {
      companyName = json['companies']['name'] as String?;
    }

    return NotificationRecordModel(
      id: json['id'] as String,
      reminderId: json['reminder_id'] as String,
      companyId: json['company_id'] as String,
      userId: json['user_id'] as String,
      organizationId: json['organization_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String?,
      companyName: companyName,
      deliveredAt: DateTime.parse(json['delivered_at'] as String).toLocal(),
      isRead: json['is_read'] as bool,
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'] as String).toLocal()
          : null,
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
    );
  }

  /// Convert to Supabase JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reminder_id': reminderId,
      'company_id': companyId,
      'user_id': userId,
      'organization_id': organizationId,
      'title': title,
      'body': body,
      'delivered_at': deliveredAt.toIso8601String(),
      'is_read': isRead,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create for insertion (without id and timestamps)
  Map<String, dynamic> toInsertJson() {
    return {
      'reminder_id': reminderId,
      'company_id': companyId,
      'user_id': userId,
      'organization_id': organizationId,
      'title': title,
      'body': body,
      // delivered_at, is_read, read_at, created_at will be set by database
    };
  }
}
