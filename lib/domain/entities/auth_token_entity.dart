import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_entity.freezed.dart';
part 'auth_token_entity.g.dart';

/// ============================================================================
/// AUTH TOKENS ENTITY
/// ============================================================================
/// Represents the authentication tokens received from the server.
///
/// **Two-Token Strategy:**
///
/// | Token        | Lifespan    | Purpose                    | Storage      |
/// |--------------|-------------|----------------------------|--------------|
/// | Access Token | 15-60 min   | Authorize API requests     | Memory/Secure|
/// | Refresh Token| 7-30 days   | Get new access tokens      | Secure only  |
///
/// **Why Two Tokens?**
/// - Access token is used frequently → if stolen, limited damage (short life)
/// - Refresh token is used rarely → can be monitored, revoked if suspicious
/// - Separation of concerns: authentication vs. authorization
/// ============================================================================

@freezed
abstract class AuthTokens with _$AuthTokens {
  const AuthTokens._(); // Private constructor for custom methods

  const factory AuthTokens({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);

  /// ==========================================================================
  /// TOKEN INSPECTION METHODS
  /// ==========================================================================
  /// These methods help understand what's inside the tokens.
  /// In production, tokens are signed and should be verified server-side.
  /// ==========================================================================

  /// Decode the payload from a JWT token (for inspection only)
  Map<String, dynamic>? _decodeTokenPayload(String? token) {
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length < 2) return null;

      // JWT payload is the second part, base64 encoded
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Get the user ID from the access token
  String? get userId {
    final payload = _decodeTokenPayload(accessToken);
    return payload?['sub'] as String?;
  }

  /// Get the session ID from the access token
  String? get sessionId {
    final payload = _decodeTokenPayload(accessToken);
    return payload?['session_id'] as String?;
  }

  /// Get access token expiry time
  DateTime? get accessTokenExpiry {
    final payload = _decodeTokenPayload(accessToken);
    final exp = payload?['exp'] as int?;
    if (exp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  /// Get refresh token expiry time
  DateTime? get refreshTokenExpiry {
    final payload = _decodeTokenPayload(refreshToken);
    final exp = payload?['exp'] as int?;
    if (exp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  /// Check if access token is expired
  bool get isAccessTokenExpired {
    final expiry = accessTokenExpiry;
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  /// Check if refresh token is expired
  bool get isRefreshTokenExpired {
    final expiry = refreshTokenExpiry;
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  /// Check if tokens are valid (not null, not empty)
  bool get hasValidTokens {
    return accessToken?.isNotEmpty == true && refreshToken?.isNotEmpty == true;
  }

  /// Get permissions from access token
  List<String> get permissions {
    final payload = _decodeTokenPayload(accessToken);
    final perms = payload?['permissions'];
    if (perms is List) {
      return perms.cast<String>();
    }
    return [];
  }
}

extension AuthTokensExtension on AuthTokens {
  /// Check if this is an onboarding/incomplete user
  /// (has access token but no refresh token - limited session)
  bool get isOnboardingUser {
    return refreshToken?.isEmpty ?? true;
  }

  /// Get a summary of token status for debugging
  String get statusSummary {
    final buffer = StringBuffer();
    buffer.writeln('=== Token Status ===');
    buffer.writeln('User ID: ${userId ?? 'N/A'}');
    buffer.writeln('Session ID: ${sessionId ?? 'N/A'}');
    buffer.writeln('Access Token: ${accessToken != null ? '✓ Present' : '✗ Missing'}');
    buffer.writeln('  Expires: ${accessTokenExpiry ?? 'N/A'}');
    buffer.writeln('  Expired: ${isAccessTokenExpired ? 'Yes' : 'No'}');
    buffer.writeln('Refresh Token: ${refreshToken != null ? '✓ Present' : '✗ Missing'}');
    buffer.writeln('  Expires: ${refreshTokenExpiry ?? 'N/A'}');
    buffer.writeln('  Expired: ${isRefreshTokenExpired ? 'Yes' : 'No'}');
    buffer.writeln('Permissions: ${permissions.join(', ')}');
    return buffer.toString();
  }
}
