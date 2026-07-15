import 'dart:async';
import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/data/data.dart';
import 'package:v_clean_architecture/domain/domain.dart';

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteSource authRemoteSource,
    required AuthLocalStorage authLocalStorage,
    required GoogleSignIn googleSignIn,
    // required LineSDK? lineSdk,
    required ValueChanged<AuthTokens?> onAuthTokensChanged,
  }) : _authRemoteSource = authRemoteSource,
       _authLocalStorage = authLocalStorage,
       _onAuthTokensChanged = onAuthTokensChanged,
       _googleSignIn = googleSignIn;
       // _lineSdk = lineSdk;

  final AuthLocalStorage _authLocalStorage;
  final AuthRemoteSource _authRemoteSource;
  final GoogleSignIn _googleSignIn;
  // final LineSDK? _lineSdk;
  final ValueChanged<AuthTokens?> _onAuthTokensChanged;

  @override
  Future<OAuthUrl> getOAuthUrl({
    required String clientId,
    required OAuthProvider provider,
  }) {
    return _authRemoteSource.getOAuthUrl(
      clientId: clientId,
      provider: provider,
    );
  }

  @override
  Future<AuthResult> signIn({
    required String username,
    required String encryptedPassword,
  }) async {
    final authResult = await _authRemoteSource.signIn(
      username: username,
      encryptedPassword: encryptedPassword,
    );
    _handleUpdateAuthTokens(authResult);
    return authResult;
  }

  @override
  Future<String> signInWithGoogle() async {
    await _googleSignIn.initialize(
      clientId: Platform.isIOS
          ? AppEnvironment.googleIosClientId
          : AppEnvironment.googleAndroidClientId,
      serverClientId: AppEnvironment.googleSeverClientId,
    );
    final account = await _googleSignIn.authenticate();
    return account.authentication.idToken!;
  }

  @override
  Future<String> signInWithLine() async {
    // if (_lineSdk != null && await _lineSdk.currentAccessToken != null) {
    //   await _lineSdk.logout();
    // }
    // final result = await _lineSdk?.login(scopes: ['profile', 'openid']);
    // return result?.accessToken.idTokenRaw ?? '';
    return '';
  }

  @override
  Future<String> signInWithApple() async {
    // final credential = await SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    // );
    // return credential.identityToken!;
    return '';
  }

  @override
  Future<AuthResult> handleOAuthCallback({
    required String encryptedData,
    required OAuthProvider provider,
  }) async {
    final authResult = await _authRemoteSource.handleOAuthCallback(
      encryptedData: encryptedData,
      provider: provider,
    );
    _handleUpdateAuthTokens(authResult);
    return authResult;
  }

  @override
  Future<String> getPublicKey() {
    return _authRemoteSource.getPublicKey();
  }

  @override
  Future<AuthTokens?> getLocalAuthTokens() async {
    final authTokens = await _authLocalStorage.getLocalAuthTokens();
    _onAuthTokensChanged(authTokens);
    return authTokens;
  }

  @override
  Future<void> signOut() async {
    try {
      await _authRemoteSource.signOut();
    } finally {
      _onAuthTokensChanged(null);
      await Future.wait([
        _authLocalStorage.clearLocalAuthTokens(),
        _authLocalStorage.clearLoggedInUserId(),
      ]);
    }
  }

  @override
  Future<AuthTokens> refreshToken(String refreshToken) async {
    final newAuthToken = await _authRemoteSource.refreshToken(refreshToken);
    await _authLocalStorage.setLocalAuthTokens(newAuthToken);
    _onAuthTokensChanged(newAuthToken);
    return newAuthToken;
  }

  void _handleUpdateAuthTokens(AuthResult authResult) {
    var authTokens = const AuthTokens();
    if ((authResult.accessToken?.isNotEmpty ?? false) &&
        (authResult.refreshToken?.isNotEmpty ?? false)) {
      authTokens = authTokens.copyWith(
        accessToken: authResult.accessToken,
        refreshToken: authResult.refreshToken,
      );
    } else {
      authTokens = authTokens.copyWith(
        accessToken: authResult.onboardingToken,
      );
    }
    _onAuthTokensChanged(authTokens);
    unawaited(_authLocalStorage.setLocalAuthTokens(authTokens));
  }

  @override
  Future<void> setLocalAuthToken(AuthTokens token) async {
    await _authLocalStorage.setLocalAuthTokens(token);
    _onAuthTokensChanged(token);
  }

  @override
  Future<AuthTokens> exchangeToken() async {
    final response = await _authRemoteSource.exchangeToken();
    final token = AuthTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    await _authLocalStorage.setLocalAuthTokens(token);
    _onAuthTokensChanged(token);
    return response;
  }

  @override
  Future<bool> submitForgetPassword({
    required String email,
  }) {
    return _authRemoteSource.submitForgetPassword(email: email);
  }

  @override
  Future<bool> changeForgetPassword({
    required String token,
    required String newPassword,
  }) async {
    final publicKey = await _authRemoteSource.getPublicKey();
    final encryptedNewPassword = newPassword.encryptWithPublicKey(publicKey);

    return _authRemoteSource.changeForgetPassword(
      token: token,
      newPassword: encryptedNewPassword,
    );
  }

  @override
  Future<bool> changeUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final publicKey = await _authRemoteSource.getPublicKey();
    final encryptedCurrentPassword = currentPassword.encryptWithPublicKey(
      publicKey,
    );
    final encryptedNewPassword = newPassword.encryptWithPublicKey(publicKey);

    return _authRemoteSource.changeUserPassword(
      currentPassword: encryptedCurrentPassword,
      newPassword: encryptedNewPassword,
    );
  }
}
