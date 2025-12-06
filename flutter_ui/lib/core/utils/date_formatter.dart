import 'package:intl/intl.dart';

/// Date formatting utilities
class DateFormatter {
  // Russian locale
  static const String _locale = 'ru_RU';

  /// Format date to dd.MM.yyyy
  static String formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy', _locale).format(date);
  }

  /// Format date to dd MMMM yyyy (e.g., "15 января 2025")
  static String formatDateLong(DateTime date) {
    return DateFormat('dd MMMM yyyy', _locale).format(date);
  }

  /// Format time to HH:mm
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm', _locale).format(date);
  }

  /// Format date and time to dd.MM.yyyy HH:mm
  static String formatDateTime(DateTime date) {
    return DateFormat('dd.MM.yyyy HH:mm', _locale).format(date);
  }

  /// Format date and time to dd MMMM yyyy, HH:mm
  static String formatDateTimeLong(DateTime date) {
    return DateFormat('dd MMMM yyyy, HH:mm', _locale).format(date);
  }

  /// Format date relative to now (e.g., "Сегодня", "Вчера", "15.01.2025")
  static String formatDateRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Сегодня';
    } else if (dateOnly == yesterday) {
      return 'Вчера';
    } else {
      return formatDate(date);
    }
  }

  /// Format date and time relative to now
  static String formatDateTimeRelative(DateTime date) {
    final dateStr = formatDateRelative(date);
    final timeStr = formatTime(date);
    return '$dateStr, $timeStr';
  }

  /// Get time ago (e.g., "5 минут назад", "2 часа назад")
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Только что';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${_minutesWord(minutes)} назад';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${_hoursWord(hours)} назад';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${_daysWord(days)} назад';
    } else {
      return formatDate(date);
    }
  }

  // Helper methods for Russian pluralization
  static String _minutesWord(int minutes) {
    if (minutes % 10 == 1 && minutes % 100 != 11) {
      return 'минуту';
    } else if ([2, 3, 4].contains(minutes % 10) &&
        ![12, 13, 14].contains(minutes % 100)) {
      return 'минуты';
    } else {
      return 'минут';
    }
  }

  static String _hoursWord(int hours) {
    if (hours % 10 == 1 && hours % 100 != 11) {
      return 'час';
    } else if ([2, 3, 4].contains(hours % 10) &&
        ![12, 13, 14].contains(hours % 100)) {
      return 'часа';
    } else {
      return 'часов';
    }
  }

  static String _daysWord(int days) {
    if (days % 10 == 1 && days % 100 != 11) {
      return 'день';
    } else if ([2, 3, 4].contains(days % 10) &&
        ![12, 13, 14].contains(days % 100)) {
      return 'дня';
    } else {
      return 'дней';
    }
  }
}
