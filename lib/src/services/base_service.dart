import '../core/http_client.dart';
import '../core/types.dart';

/// Base class for all API services.
abstract class BaseService {
  BaseService(this._http);

  final ApiHttpClient _http;

  /// The HTTP client instance.
  ApiHttpClient get http => _http;

  /// Builds the full URL for an endpoint.
  String buildUrl(String path) => _http.joinUrl(_http.baseUrl, path);

  /// Executes a GET request.
  Future<Json> get(String path, [RequestOptions options = const RequestOptions()]) =>
      _http.get(path, options);

  /// Executes a POST request.
  Future<Json> post(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      _http.post(path, body, options);

  /// Executes a PUT request.
  Future<Json> put(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      _http.put(path, body, options);

  /// Executes a PATCH request.
  Future<Json> patch(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      _http.patch(path, body, options);

  /// Executes a DELETE request.
  Future<Json> delete(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      _http.delete(path, body, options);

  /// Downloads raw bytes (PDF, images, etc.).
  Future<List<int>> download(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      _http.bytes(HttpMethod.get, path, body: body, options: options.copyWith(responseType: ResponseType.bytes));
}