abstract class BaseHttpClient {
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  });

  Future<dynamic> post(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
  });

  Future<dynamic> patch(
    String uri, {
    Map<String, dynamic>? headers,
    dynamic body,
  });

  Future<dynamic> put(
    String uri, {
    Map<String, dynamic>? headers,
    dynamic body,
  });

  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? headers,
    dynamic body,
  });

  Future<dynamic> download(
    String uri,
    dynamic savePath, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    dynamic body,
    void Function(int received, int total)? onReceiveProgress,
  });
}
