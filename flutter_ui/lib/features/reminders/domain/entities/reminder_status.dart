/// Reminder status
///
/// Represents the lifecycle state of a reminder:
/// - pending: Reminder is scheduled but not yet delivered
/// - delivered: Reminder notification was shown to the user
/// - cancelled: Reminder was cancelled before delivery
enum ReminderStatus {
  pending,
  delivered,
  cancelled;

  /// Convert from string (database value)
  static ReminderStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return ReminderStatus.pending;
      case 'delivered':
        return ReminderStatus.delivered;
      case 'cancelled':
        return ReminderStatus.cancelled;
      default:
        throw ArgumentError('Invalid reminder status: $value');
    }
  }

  /// Convert to string (database value)
  String toString() {
    switch (this) {
      case ReminderStatus.pending:
        return 'pending';
      case ReminderStatus.delivered:
        return 'delivered';
      case ReminderStatus.cancelled:
        return 'cancelled';
    }
  }

  /// Get display name in Russian
  String get displayName {
    switch (this) {
      case ReminderStatus.pending:
        return 'Ожидает';
      case ReminderStatus.delivered:
        return 'Доставлено';
      case ReminderStatus.cancelled:
        return 'Отменено';
    }
  }
}
