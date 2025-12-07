import 'reminder_status.dart';

/// Reminder entity
///
/// Represents a scheduled reminder for a company.
class Reminder {
  final String id;
  final String companyId;
  final String title;
  final String? description;
  final DateTime scheduledFor;
  final ReminderStatus status;
  final String createdByUserId;
  final String? companyName; // Denormalized from companies table

  const Reminder({
    required this.id,
    required this.companyId,
    required this.title,
    this.description,
    required this.scheduledFor,
    required this.status,
    required this.createdByUserId,
    this.companyName,
  });

  /// Check if reminder is in the past
  bool get isPast => scheduledFor.isBefore(DateTime.now());

  /// Check if reminder is today
  bool get isToday {
    final now = DateTime.now();
    return scheduledFor.year == now.year &&
        scheduledFor.month == now.month &&
        scheduledFor.day == now.day;
  }

  /// Copy with new values
  Reminder copyWith({
    String? id,
    String? companyId,
    String? title,
    String? description,
    DateTime? scheduledFor,
    ReminderStatus? status,
    String? createdByUserId,
    String? companyName,
  }) {
    return Reminder(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      status: status ?? this.status,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      companyName: companyName ?? this.companyName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reminder &&
        other.id == id &&
        other.companyId == companyId &&
        other.title == title &&
        other.description == description &&
        other.scheduledFor == scheduledFor &&
        other.status == status &&
        other.createdByUserId == createdByUserId &&
        other.companyName == companyName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        scheduledFor.hashCode ^
        status.hashCode ^
        createdByUserId.hashCode ^
        companyName.hashCode;
  }

  @override
  String toString() {
    return 'Reminder(id: $id, companyId: $companyId, title: $title, description: $description, scheduledFor: $scheduledFor, status: $status, createdByUserId: $createdByUserId, companyName: $companyName)';
  }
}
