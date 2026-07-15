import 'dart:convert';

import 'package:app_core/app_core.dart';
import 'package:v_clean_architecture/constants/app_local_storage_key.dart';
import 'package:v_clean_architecture/domain/domain.dart';

/// ============================================================================
/// AUTH LOCAL STORAGE
/// ============================================================================
/// This class handles secure local storage of authentication tokens.
/// 
/// **Token Flow:**
/// 1. User logs in → receives access_token + refresh_token
/// 2. Tokens are encrypted and stored locally (secure storage)
/// 3. On app launch, tokens are retrieved to restore session
/// 4. Access token is used for API calls (short-lived: ~15-60 min)
/// 5. When access token expires, refresh token is used to get new tokens
/// 6. On logout, all tokens are cleared
/// ============================================================================

abstract class AuthLocalStorage {
  /// Store auth tokens securely (encrypted)
  Future<void> setLocalAuthTokens(AuthTokens? tokens);
  
  /// Retrieve stored auth tokens (decrypted)
  Future<AuthTokens?> getLocalAuthTokens();
  
  /// Clear all auth tokens (on logout)
  Future<void> clearLocalAuthTokens();

  /// Store the logged-in user ID for quick reference
  Future<void> setLoggedInUserId(String userId);
  Future<String?> getLoggedInUserId();
  Future<void> clearLoggedInUserId();
}

final class AuthLocalStorageImpl implements AuthLocalStorage {
  AuthLocalStorageImpl({required LocalStorage localStorage})
    : _localStorage = localStorage;

  final LocalStorage _localStorage;
  
  /// In-memory cache for demo mode (simulates persistent storage)
  static AuthTokens? _cachedTokens;
  static String? _cachedUserId;

  @override
  Future<AuthTokens?> getLocalAuthTokens() async {
    // =========================================================================
    // DEMO MODE: Return cached tokens if available
    // =========================================================================
    // In production, tokens would be retrieved from secure encrypted storage.
    // The tokens are stored encrypted to prevent unauthorized access.
    // =========================================================================
    
    if (_cachedTokens != null) {
      return _cachedTokens;
    }
    
    // Try to get from actual storage first
    final jsonString = await _localStorage.getString(
      AppLocalStorageKey.authTokens,
      shouldDecrypt: true,
    );
    
    if (jsonString != null) {
      final tokens = AuthTokens.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      _cachedTokens = tokens;
      return tokens;
    }
    
    // No stored tokens - user needs to login
    return null;
  }

  @override
  Future<void> setLocalAuthTokens(AuthTokens? tokens) async {
    // =========================================================================
    // STORING TOKENS SECURELY
    // =========================================================================
    // Tokens are encrypted before storage to prevent:
    // - Unauthorized access if device is compromised
    // - Token theft from app data backup
    // - Reading tokens via debugging tools
    // =========================================================================
    
    _cachedTokens = tokens;
    
    if (tokens != null) {
      await _localStorage.setString(
        AppLocalStorageKey.authTokens,
        jsonEncode(tokens.toJson()),
        shouldEncrypt: true,
      );
    }
  }

  @override
  Future<void> clearLocalAuthTokens() async {
    // =========================================================================
    // LOGOUT: Clear all authentication data
    // =========================================================================
    // Important: Clear both memory cache and persistent storage
    // This ensures complete logout even if app is force-closed
    // =========================================================================
    
    _cachedTokens = null;
    await _localStorage.delete(key: AppLocalStorageKey.authTokens);
  }

  @override
  Future<void> clearLoggedInUserId() async {
    _cachedUserId = null;
    return _localStorage.delete(key: AppLocalStorageKey.userId);
  }

  @override
  Future<String?> getLoggedInUserId() async {
    if (_cachedUserId != null) return _cachedUserId;
    
    return _localStorage.getString(
      AppLocalStorageKey.userId,
      shouldDecrypt: true,
    );
  }

  @override
  Future<void> setLoggedInUserId(String userId) {
    _cachedUserId = userId;
    return _localStorage.setString(
      AppLocalStorageKey.userId,
      userId,
      shouldEncrypt: true,
    );
  }
}
