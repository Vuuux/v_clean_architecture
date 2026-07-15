import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:v_clean_architecture/domain/domain.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required ValueGetter<AuthTokens?> getAuthTokens,
    required ValueGetter<AuthRepository> getAuthRepository,
    List<Interceptor>? retryInterceptors,
  }) : _getAuthTokens = getAuthTokens,
       _getAuthRepository = getAuthRepository,
       _retryInterceptors = retryInterceptors;

  final ValueGetter<AuthTokens?> _getAuthTokens;
  final ValueGetter<AuthRepository> _getAuthRepository;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;
  final List<Interceptor>? _retryInterceptors;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authTokens = _getAuthTokens();
    if (authTokens != null) {
      options.headers['Authorization'] = 'Bearer ${authTokens.accessToken}';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      if (_isRefreshing) {
        await _refreshCompleter?.future;
        final retryResponse = await retryHandler(
          request: err.requestOptions,
          newAuthTokens: _getAuthTokens()!,
        );
        return handler.resolve(retryResponse);
      }
      _isRefreshing = true;
      _refreshCompleter = Completer();

      try {
        final lastAuthTokens = _getAuthTokens();

        if (lastAuthTokens == null || lastAuthTokens.refreshToken == null) {
          _isRefreshing = false;
          _refreshCompleter?.complete();
          return handler.reject(err);
        }

        final newAuthTokens = await _getAuthRepository().refreshToken(
          lastAuthTokens.refreshToken!,
        );

        _refreshCompleter?.complete();
        _isRefreshing = false;

        final retryResponse = await retryHandler(
          request: err.requestOptions,
          newAuthTokens: newAuthTokens,
        );
        return handler.resolve(retryResponse);
      } catch (e) {
        if (_refreshCompleter?.isCompleted == false) {
          _refreshCompleter?.completeError(e);
        }
        _isRefreshing = false;
        return handler.reject(err);
      }
    }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> retryHandler({
    required RequestOptions request,
    required AuthTokens newAuthTokens,
  }) async {
    try {
      request.headers['Authorization'] = 'Bearer ${newAuthTokens.accessToken}';
      final retryDio = Dio();
      if (_retryInterceptors != null) {
        retryDio.interceptors.addAll(_retryInterceptors);
      }
      final response = retryDio.fetch<dynamic>(request);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Retry request failed: $e');
      }
      rethrow;
    }
  }
}
