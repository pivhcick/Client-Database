import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for sensitive data (JWT tokens, etc.)
///
/// Uses platform-specific secure storage:
/// - iOS: Keychain
/// - Android: KeyStore
class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Keys
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyOrganizationId = 'organization_id';

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _keyAccessToken, value: token);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefreshToken, value: token);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  /// Get user ID
  Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  /// Save organization ID
  Future<void> saveOrganizationId(String organizationId) async {
    await _storage.write(key: _keyOrganizationId, value: organizationId);
  }

  /// Get organization ID
  Future<String?> getOrganizationId() async {
    return await _storage.read(key: _keyOrganizationId);
  }

  /// Check if user is logged in
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all stored data (logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Clear specific keys
  Future<void> clearTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
  }
}
