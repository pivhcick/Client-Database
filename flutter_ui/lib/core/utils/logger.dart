import 'package:flutter/foundation.dart';

/// Centralized logging utility for the application.
///
/// Provides structured logging with different levels and automatic
/// debug mode filtering. All logs are disabled in release builds.
class AppLogger {
  static bool _debugMode = kDebugMode;

  /// Enable or disable debug mode manually
  static void setDebugMode(bool enabled) {
    _debugMode = enabled;
  }

  /// Check if debug mode is enabled
  static bool get isDebugMode => _debugMode;

  /// Log debug information (only in debug mode)
  static void debug(String message, [String? tag]) {
    if (_debugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('🔍 DEBUG: $prefix$message');
    }
  }

  /// Log informational messages
  static void info(String message, [String? tag]) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('ℹ️ INFO: $prefix$message');
  }

  /// Log warning messages
  static void warning(String message, [String? tag]) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('⚠️ WARNING: $prefix$message');
  }

  /// Log error messages with optional error object and stack trace
  static void error(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  ]) {
    final prefix = tag != null ? '[$tag] ' : '';
    debugPrint('❌ ERROR: $prefix$message');
    if (error != null) {
      debugPrint('  Error: $error');
    }
    if (stackTrace != null && _debugMode) {
      debugPrint('  Stack trace:\n$stackTrace');
    }
  }

  /// Log successful operations
  static void success(String message, [String? tag]) {
    if (_debugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('✅ SUCCESS: $prefix$message');
    }
  }

  /// Log timer/scheduled operations
  static void timer(String message, [String? tag]) {
    if (_debugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('⏰ TIMER: $prefix$message');
    }
  }

  /// Log network operations
  static void network(String message, [String? tag]) {
    if (_debugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('🌐 NETWORK: $prefix$message');
    }
  }

  /// Log database operations
  static void database(String message, [String? tag]) {
    if (_debugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('🗄️ DATABASE: $prefix$message');
    }
  }

  /// Log notification operations
  static void notification(String message, [String? tag]) {
    if (_debugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      debugPrint('🔔 NOTIFICATION: $prefix$message');
    }
  }
}
