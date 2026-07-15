import 'dart:io';

import 'package:flutter/foundation.dart';

class GlobalHttpOverrides extends HttpOverrides {
  GlobalHttpOverrides({required this.globalHeaders});

  final Map<String, String> globalHeaders;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    if (kDebugMode) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    }
    return _GlobalHttpClient(client, globalHeaders);
  }
}

class _GlobalHttpClient implements HttpClient {
  _GlobalHttpClient(this._inner, this.headers);

  final HttpClient _inner;
  final Map<String, String> headers;

  Future<HttpClientRequest> _updateHeaders(
    Future<HttpClientRequest> httpClientRequest,
  ) async {
    final request = await httpClientRequest;
    headers.forEach((key, value) {
      request.headers.set(key, value);
    });
    return request;
  }

  @override
  Future<HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) => _updateHeaders(_inner.open(method, host, port, path));

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) =>
      _updateHeaders(_inner.openUrl(method, url));

  @override
  Future<HttpClientRequest> get(String host, int port, String path) =>
      _updateHeaders(_inner.get(host, port, path));

  @override
  Future<HttpClientRequest> getUrl(Uri url) =>
      _updateHeaders(_inner.getUrl(url));

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  Duration? connectionTimeout;

  @override
  bool autoUncompress = true;

  @override
  String? get userAgent => _inner.userAgent;

  @override
  set userAgent(String? value) => _inner.userAgent = value;

  @override
  void close({bool force = false}) => _inner.close(force: force);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      _inner.noSuchMethod(invocation);
}
