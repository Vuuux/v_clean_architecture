// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException({
    required this.statusCode,
    this.message,
    this.code = '',
    this.data = const {},
    this.requestOptions,
    this.isNetworkError = false,
  });

  int statusCode;
  String? code;
  String? message;
  Map<String, dynamic> data;
  RequestOptions? requestOptions;
  bool isNetworkError;

  // Convenience getters
  String? get method => requestOptions?.method;
  String? get url => requestOptions?.uri.toString();
  String? get path => requestOptions?.path;
  Map<String, dynamic>? get headers => requestOptions?.headers;
  Map<String, dynamic>? get queryParameters => requestOptions?.queryParameters;
  dynamic get requestData => requestOptions?.data;

  @override
  String toString() {
    return '''ApiException(statusCode: $statusCode, code: $code, message: $message, method: $method, url: $url, data: $data , isNetworkError: $isNetworkError)''';
  }
}
