// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../http_client/api_exception.dart';
import 'error_messages.dart';

class BlocErrorHandler extends BlocObserver {
  BlocErrorHandler({
    required this.displayError,
    required this.forceLogoutHandler,
  });

  final void Function(String title, String? message) displayError;
  final VoidCallback forceLogoutHandler;

  String? _lastErrorCode;
  DateTime? _lastErrorTime;
  static const _debounceDuration = Duration(milliseconds: 500);

  bool _isLoggingOut = false;

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (error is! ApiException) {
      if (_shouldShowError(null)) {
        _showError(ErrorMessagesMap.defaultError);
      }
      return;
    }

    final errorCode = error.code;

    if (ErrorCodes.unauthorizedCodes.contains(errorCode)) {
      if (!_isLoggingOut) {
        _isLoggingOut = true;
        _showError(ErrorMessagesMap.getErrorMessage(errorCode));
        forceLogoutHandler();

        Future.delayed(const Duration(seconds: 2), () {
          _isLoggingOut = false;
          _resetDebounce();
        });
      }
      return;
    }

    if (!_shouldShowError(errorCode)) {
      return;
    }

    if (errorCode != null && ErrorMessagesMap.messages.containsKey(errorCode)) {
      _showError(ErrorMessagesMap.getErrorMessage(errorCode));
      return;
    }

    if (error.message != null) {
      displayError('เกิดข้อผิดพลาด!', error.message);
      return;
    }

    final defaultError = ErrorMessagesMap.getDefaultErrorByRequestType(
      method: error.method,
      isUpload: _isUploadRequest(error),
    );
    _showError(defaultError);
  }

  bool _shouldShowError(String? errorCode) {
    final now = DateTime.now();

    if (_lastErrorCode == errorCode &&
        _lastErrorTime != null &&
        now.difference(_lastErrorTime!) < _debounceDuration) {
      return false;
    }

    _lastErrorCode = errorCode;
    _lastErrorTime = now;
    return true;
  }

  void _resetDebounce() {
    _lastErrorCode = null;
    _lastErrorTime = null;
  }

  void _showError(ErrorMessage error) {
    displayError(error.title, error.message);
  }

  // Helper method to detect upload request
  bool _isUploadRequest(ApiException error) {
    // Check if Content-Type header contains multipart/form-data
    if (error.headers != null) {
      final contentType =
          error.headers!['Content-Type']?.toString() ??
          error.headers!['content-type']?.toString() ??
          '';
      if (contentType.toLowerCase().contains('multipart/form-data')) {
        return true;
      }
    }

    // Check if request data is FormData
    if (error.requestData is FormData) {
      return true;
    }

    // Check if URL path contains upload endpoint
    final path = error.path?.toLowerCase() ?? '';
    if (path.contains('/upload')) {
      return true;
    }

    return false;
  }
}
