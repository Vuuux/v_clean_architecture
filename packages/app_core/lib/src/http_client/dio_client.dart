// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:dio/dio.dart';

import 'client.dart';

final class DioClient extends BaseHttpClient {
  DioClient(
    this._dio, {
    required String host,
    this.headers,
    List<Interceptor> interceptors = const [],
  }) {
    _dio
      ..options.baseUrl = host
      ..options.headers = {if (headers != null) ...headers!};
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  final Dio _dio;
  Map<String, dynamic>? headers;

  // GET:-----------------------------------------------------------------------
  @override
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: params,
        options: Options(headers: {...this.headers ?? {}, ...headers ?? {}}),
      );
      return onResponse(response);
    } catch (e) {
      if (e is DioException) {
        return onError(response: e.response, error: e);
      } else {
        rethrow;
      }
    }
  }

  // POST:----------------------------------------------------------------------
  @override
  Future<dynamic> post(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: body,
        queryParameters: params,
        options: Options(headers: {...this.headers ?? {}, ...headers ?? {}}),
      );
      return onResponse(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return onError(response: e.response, error: e);
        }
      } else {
        rethrow;
      }
    }
  }

  // PATCH:---------------------------------------------------------------------
  @override
  Future<dynamic> patch(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    try {
      final response = await _dio.patch(
        uri,
        data: body,
        queryParameters: params,
        options: Options(headers: {...this.headers ?? {}, ...headers ?? {}}),
      );
      return onResponse(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return onError(response: e.response, error: e);
        }
      } else {
        rethrow;
      }
    }
  }

  // PUT:-----------------------------------------------------------------------
  @override
  Future<dynamic> put(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: body,
        queryParameters: params,
        options: Options(headers: {...this.headers ?? {}, ...headers ?? {}}),
      );
      return onResponse(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return onError(response: e.response, error: e);
        }
      } else {
        rethrow;
      }
    }
  }

  // DELETE:--------------------------------------------------------------------
  @override
  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: body,
        queryParameters: params,
        options: Options(headers: {...this.headers ?? {}, ...headers ?? {}}),
      );
      return onResponse(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return onError(response: e.response, error: e);
        }
      } else {
        rethrow;
      }
    }
  }

  // DOWNLOAD:------------------------------------------------------------------
  @override
  Future<dynamic> download(
    String uri,
    dynamic savePath, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        uri,
        savePath,
        data: body,
        onReceiveProgress: onReceiveProgress,
        queryParameters: params,
        options: Options(headers: {...this.headers ?? {}, ...headers ?? {}}),
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return onError(response: e.response, error: e);
        }
      } else {
        rethrow;
      }
    }
  }
}

extension DioClientExt on DioClient {
  dynamic onResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        final data = response.data;
        if (data is String) {
          return jsonDecode(data);
        }
        return data;
      case 302:
        return response;
      default:
        throw _buildApiException(response: response);
    }
  }

  dynamic onError({required Response<dynamic>? response, DioException? error}) {
    return throw _buildApiException(response: response, error: error);
  }

  bool _checkIfNetworkError(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.type == DioExceptionType.unknown &&
            error.error.toString().contains('SocketException'));
  }

  ApiException _buildApiException({
    Response<dynamic>? response,
    DioException? error,
  }) {
    var message = '';
    var code = '';
    var data = <String, dynamic>{};
    final responseData = response?.data;
    if (responseData is Map<String, dynamic>) {
      message = responseData['error'].toString();
      code = responseData['code'].toString();
      data = responseData['data'] is Map<String, dynamic>
          ? responseData['data'] as Map<String, dynamic>
          : {};
    } else if (response?.statusMessage != null &&
        response!.statusMessage!.isNotEmpty) {
      message = response.statusMessage ?? '';
      data = response.extra;
    }

    final isNetworkError = error != null && _checkIfNetworkError(error);

    return ApiException(
      statusCode: response?.statusCode ?? 0,
      code: code,
      message: message,
      data: data,
      requestOptions: response?.requestOptions,
      isNetworkError: isNetworkError,
    );
  }
}
