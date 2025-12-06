import 'package:hive_flutter/hive_flutter.dart';

/// Hive storage for offline caching
///
/// Used for caching companies, users, and other data
/// for offline access
class HiveStorage {
  static final HiveStorage _instance = HiveStorage._internal();
  factory HiveStorage() => _instance;
  HiveStorage._internal();

  // Box names
  static const String _companiesBox = 'companies';
  static const String _usersBox = 'users';
  static const String _contactPersonsBox = 'contact_persons';
  static const String _contactRecordsBox = 'contact_records';
  static const String _remindersBox = 'reminders';
  static const String _settingsBox = 'settings';

  bool _initialized = false;

  /// Initialize Hive
  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    // Open boxes
    await Hive.openBox(_companiesBox);
    await Hive.openBox(_usersBox);
    await Hive.openBox(_contactPersonsBox);
    await Hive.openBox(_contactRecordsBox);
    await Hive.openBox(_remindersBox);
    await Hive.openBox(_settingsBox);

    _initialized = true;
  }

  /// Get companies box
  Box get companiesBox => Hive.box(_companiesBox);

  /// Get users box
  Box get usersBox => Hive.box(_usersBox);

  /// Get contact persons box
  Box get contactPersonsBox => Hive.box(_contactPersonsBox);

  /// Get contact records box
  Box get contactRecordsBox => Hive.box(_contactRecordsBox);

  /// Get reminders box
  Box get remindersBox => Hive.box(_remindersBox);

  /// Get settings box
  Box get settingsBox => Hive.box(_settingsBox);

  /// Clear all cached data
  Future<void> clearAll() async {
    await companiesBox.clear();
    await usersBox.clear();
    await contactPersonsBox.clear();
    await contactRecordsBox.clear();
    await remindersBox.clear();
    // Don't clear settings box
  }

  /// Clear specific box
  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  /// Close all boxes
  Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }
}
