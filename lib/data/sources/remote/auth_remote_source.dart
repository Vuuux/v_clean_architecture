import 'dart:convert';
import 'dart:math';

import 'package:app_core/app_core.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/domain/domain.dart';

/// ============================================================================
/// AUTH REMOTE SOURCE - API Communication Layer
/// ============================================================================
///
/// **Understanding JWT Tokens:**
///
/// JWT (JSON Web Token) consists of 3 parts: HEADER.PAYLOAD.SIGNATURE
///
/// 1. **Access Token** (Short-lived: 15-60 minutes)
///    - Used to authenticate API requests
///    - Sent in Authorization header: "Bearer <access_token>"
///    - Contains user ID, permissions, expiry time
///    - Short lifespan limits damage if stolen
///
/// 2. **Refresh Token** (Long-lived: 7-30 days)
///    - Used ONLY to get new access tokens
///    - Stored securely, never sent to regular API endpoints
///    - Can be revoked server-side for security
///    - If stolen, user must re-login
///
/// **Token Flow:**
/// ```
/// [Login] → AccessToken + RefreshToken
///     ↓
/// [API Call] → Send AccessToken in header
///     ↓
/// [Token Expired?] → Use RefreshToken to get new AccessToken
///     ↓
/// [Refresh Failed?] → Force logout, user must re-login
/// ```
/// ============================================================================

class _AuthApi {
  static const String baseAuth = 'v1/auth';
  static const String getPublicKey = '$baseAuth/public-key';
  static const String login = '$baseAuth/login';
  static const String logout = '$baseAuth/logout';
  static const String refreshToken = '$baseAuth/refresh';
  static const String exchangeToken = '$baseAuth/token/exchange';
  static const String forgetPassword = '$baseAuth/password/forget';
  static const String changeForgetPassword =
      '$baseAuth/password/forget/confirm';
  static const String changeUserPassword = '$baseAuth/password/change';

  static const String baseOAuth = 'v1/oauth';
  static const String oAuthUrl = '$baseOAuth/url';
  static const String oAuthCallback = '$baseOAuth/mobile-callback';
}

abstract class AuthRemoteSource {
  Future<OAuthUrl> getOAuthUrl({
    required String clientId,
    required OAuthProvider provider,
  });

  Future<String> getPublicKey();

  Future<AuthResult> signIn({
    required String username,
    required String encryptedPassword,
  });

  Future<bool> signOut();

  Future<AuthResult> handleOAuthCallback({
    required String encryptedData,
    required OAuthProvider provider,
  });

  Future<AuthTokens> refreshToken(String refreshToken);

  Future<AuthTokens> exchangeToken();

  Future<bool> submitForgetPassword({required String email});

  Future<bool> changeForgetPassword({
    required String token,
    required String newPassword,
  });

  Future<bool> changeUserPassword({
    required String currentPassword,
    required String newPassword,
  });
}

final class AuthRemoteSourceImpl implements AuthRemoteSource {
  AuthRemoteSourceImpl({required BaseHttpClient identityClient})
    : _identityClient = identityClient;

  final BaseHttpClient _identityClient;

  /// ==========================================================================
  /// DEMO: Generate realistic JWT-like tokens
  /// ==========================================================================
  /// In production, these come from your authentication server.
  /// The server generates signed tokens that can be verified.
  /// ==========================================================================

  AuthTokens _generateDemoTokens({required String userId}) {
    final now = DateTime.now();
    final random = Random();
    final sessionId = random.nextInt(999999).toString().padLeft(6, '0');

    // Access Token Payload
    final accessTokenPayload = {
      'sub': userId,
      'iat': now.millisecondsSinceEpoch ~/ 1000,
      'exp': now.add(const Duration(minutes: 30)).millisecondsSinceEpoch ~/ 1000,
      'type': 'access',
      'session_id': sessionId,
      'permissions': ['read', 'write', 'profile'],
    };

    // Refresh Token Payload
    final refreshTokenPayload = {
      'sub': userId,
      'iat': now.millisecondsSinceEpoch ~/ 1000,
      'exp': now.add(const Duration(days: 7)).millisecondsSinceEpoch ~/ 1000,
      'type': 'refresh',
      'session_id': sessionId,
    };

    // Create JWT-like structure
    const header = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9';
    final accessPayloadB64 = base64Url.encode(utf8.encode(jsonEncode(accessTokenPayload)));
    final refreshPayloadB64 = base64Url.encode(utf8.encode(jsonEncode(refreshTokenPayload)));
    const signature = 'demo_signature';

    return AuthTokens(
      accessToken: '$header.$accessPayloadB64.$signature',
      refreshToken: '$header.$refreshPayloadB64.$signature',
    );
  }

  @override
  Future<OAuthUrl> getOAuthUrl({
    required String clientId,
    required OAuthProvider provider,
  }) async {
    final response = await _identityClient.get(
      _AuthApi.oAuthUrl,
      params: {'client_id': clientId, 'provider': provider.name},
    );

    return OAuthUrl.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<AuthResult> handleOAuthCallback({
    required String encryptedData,
    required OAuthProvider provider,
  }) async {
    final response = await _identityClient.post(
      _AuthApi.oAuthCallback,
      body: {'data': encryptedData, 'provider': provider.name},
    );
    return AuthResult.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<String> getPublicKey() async {
    // ==========================================================================
    // DEMO MODE: Return sample public key
    // ==========================================================================
    return 'demo_public_key_RSA_2048';

    // Production mode:
    // final response = await _identityClient.get(_AuthApi.getPublicKey);
    // if (response is! Map<String, dynamic> || !response.containsKey('key')) {
    //   throw Exception('Invalid public key result');
    // }
    // return response['key'] as String;
  }

  @override
  Future<AuthResult> signIn({
    required String username,
    required String encryptedPassword,
  }) async {
    // ==========================================================================
    // DEMO MODE: Accept any credentials and return demo tokens
    // ==========================================================================
    await Future<void>.delayed(const Duration(milliseconds: 800));

if (username.isEmpty || encryptedPassword.isEmpty) {
      throw ApiException(statusCode: 401, message: 'Invalid credentials');
    }

    final userId = 'user_${username.hashCode.abs()}';
    final tokens = _generateDemoTokens(userId: userId);

    return AuthResult(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      isRegister: false,
    );

    // Production mode:
    // final response = await _identityClient.post(
    //   _AuthApi.login,
    //   body: {
    //     'client_id': AppEnvironment.clientId,
    //     'username': username,
    //     'password': encryptedPassword,
    //   },
    // );
    // return AuthResult.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<bool> signOut() async {
    // ==========================================================================
    // DEMO MODE: Simulate logout
    // ==========================================================================
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return true;

    // Production mode:
    // final response = await _identityClient.post(_AuthApi.logout);
    // return response is Map<String, dynamic> && response['success'] == true;
  }

  @override
  Future<AuthTokens> refreshToken(String refreshToken) async {
    // ==========================================================================
    // DEMO MODE: Generate new tokens from refresh token
    // ==========================================================================
    await Future<void>.delayed(const Duration(milliseconds: 500));

    try {
      final parts = refreshToken.split('.');
      if (parts.length >= 2) {
        final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
        ) as Map<String, dynamic>;
        final userId = payload['sub'] as String? ?? 'demo_user';
        return _generateDemoTokens(userId: userId);
      }
    } catch (_) {}

    return _generateDemoTokens(userId: 'demo_user');

    // Production mode:
    // final response = await _identityClient.post(
    //   _AuthApi.refreshToken,
    //   body: {'refresh_token': refreshToken},
    // );
    // return AuthTokens.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<AuthTokens> exchangeToken() async {
    // ==========================================================================
    // DEMO MODE: Return exchanged tokens
    // ==========================================================================
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _generateDemoTokens(userId: 'exchanged_user');

    // Production mode:
    // final response = await _identityClient.post(_AuthApi.exchangeToken);
    // return AuthTokens.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<bool> changeForgetPassword({
    required String token,
    required String newPassword,
  }) async {
    // DEMO MODE
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return true;

    // Production mode:
    // final response = await _identityClient.post(
    //   _AuthApi.changeForgetPassword,
    //   body: {'token': token, 'password': newPassword},
    // );
    // return response is Map<String, dynamic> && response['is_success'] == true;
  }

  @override
  Future<bool> submitForgetPassword({required String email}) async {
    // DEMO MODE
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return true;

    // Production mode:
    // final response = await _identityClient.post(
    //   _AuthApi.forgetPassword,
    //   body: {'email': email, 'client_id': AppEnvironment.clientId},
    // );
    // return response is Map<String, dynamic> && response['is_success'] == true;
  }

  @override
  Future<bool> changeUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // DEMO MODE
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return true;

    // Production mode:
    // final response = await _identityClient.post(
    //   _AuthApi.changeUserPassword,
    //   body: {'current_password': currentPassword, 'password': newPassword},
    // );
    // return response is Map<String, dynamic> && response['is_success'] == true;
  }
}
