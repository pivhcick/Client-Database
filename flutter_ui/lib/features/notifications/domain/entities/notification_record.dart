/// Notification record entity
///
/// Represents a delivered notification that was shown to the user.
class NotificationRecord {
  final String id;
  final String reminderId;
  final String companyId;
  final String userId;
  final String organizationId;

  final String title;
  final String? body;
  final String? companyName; // Denormalized from companies table

  final DateTime deliveredAt;
  final bool isRead;
  final DateTime? readAt;

  final DateTime createdAt;

  const NotificationRecord({
    required this.id,
    required this.reminderId,
    required this.companyId,
    required this.userId,
    required this.organizationId,
    required this.title,
    this.body,
    this.companyName,
    required this.deliveredAt,
    required this.isRead,
    this.readAt,
    required this.createdAt,
  });

  /// Create a copy with updated fields
  NotificationRecord copyWith({
    String? id,
    String? reminderId,
    String? companyId,
    String? userId,
    String? organizationId,
    String? title,
    String? body,
    String? companyName,
    DateTime? deliveredAt,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return NotificationRecord(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      companyId: companyId ?? this.companyId,
      userId: userId ?? this.userId,
      organizationId: organizationId ?? this.organizationId,
      title: title ?? this.title,
      body: body ?? this.body,
      companyName: companyName ?? this.companyName,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
