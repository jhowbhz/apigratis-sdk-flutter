import 'dart:convert';

import 'env.dart';
import 'errors.dart';
import 'retry.dart';
import 'transport.dart';
import 'types.dart';

/// Base padrão da API.
const String defaultBaseUrl = 'https://gateway.apibrasil.io/api/v2';

/// Timeout padrão das requisições.
const Duration defaultTimeout = Duration(seconds: 30);

/// User-Agent enviado pela SDK.
const String sdkUserAgent = 'APIBRASIL/SDK-DART';

/// Cliente HTTP interno da SDK. Injeta os headers de autenticação da
/// plataforma (`Authorization: Bearer`, `DeviceToken`, `SecretKey`),
/// aplica retry com backoff, dispara hooks de observabilidade e converte
/// falhas em subclasses de [ApiBrasilError].
class ApiHttpClient {
  ApiHttpClient([ApiBrasilConfig config = const ApiBrasilConfig()])
      : this._(configFromEnv().merge(config));

  ApiHttpClient._(ApiBrasilConfig config)
      : _config = config,
        _bearerToken = config.bearerToken,
        _deviceToken = config.deviceToken,
        _transport = config.transport ?? HttpTransport(),
        _retry = resolveRetry(config.retry),
        _hooks = config.hooks ?? const ApiBrasilHooks();

  final ApiBrasilConfig _config;
  final Transport _transport;
  final RetryConfig _retry;
  final ApiBrasilHooks _hooks;

  String? _bearerToken;
  String? _deviceToken;

  /// Base da API em uso.
  String get baseUrl => _config.baseUrl ?? defaultBaseUrl;

  String? get bearerToken => _bearerToken;

  String? get deviceToken => _deviceToken;

  String? get secretKey => _config.secretKey;

  /// Transporte HTTP em uso.
  Transport get transport => _transport;

  /// Define/atualiza o Bearer Token — `null` remove a autenticação.
  void setBearerToken(String? token) => _bearerToken = token;

  /// Define/atualiza o DeviceToken — `null` remove o header.
  void setDeviceToken(String? token) => _deviceToken = token;

  /// Configuração atual do cliente, já resolvida com o ambiente e com os
  /// tokens em vigor.
  ApiBrasilConfig get config => ApiBrasilConfig(
        bearerToken: _bearerToken,
        deviceToken: _deviceToken,
        secretKey: _config.secretKey,
        baseUrl: _config.baseUrl,
        timeout: _config.timeout,
        headers: _config.headers,
        transport: _config.transport,
        retry: _config.retry,
        hooks: _config.hooks,
      );

  /// Fecha o transporte e libera as conexões.
  void close() => _transport.close();

  /// Executa uma requisição e devolve o corpo já decodificado.
  Future<dynamic> request(
    HttpMethod method,
    String path, {
    Object? body,
    RequestOptions options = const RequestOptions(),
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': sdkUserAgent,
      ...?_config.headers,
    };

    final bearer = options.bearerToken ?? _bearerToken;
    if (bearer != null && bearer.isNotEmpty) {
      headers['Authorization'] = 'Bearer $bearer';
    }

    final device = options.deviceToken ?? _deviceToken;
    if (device != null && device.isNotEmpty) headers['DeviceToken'] = device;

    final secret = options.secretKey;
    if (secret != null && secret.isNotEmpty) headers['SecretKey'] = secret;

    headers.addAll(options.headers ?? const {});

    final url = joinUrl(baseUrl, path) + buildQueryString(options.query);
    final serializedBody = body == null ? null : jsonEncode(body);
    final timeout = options.timeout ?? _config.timeout ?? defaultTimeout;
    final maxAttempts = 1 + _retry.retries;

    var attempt = 0;
    while (true) {
      await _hooks.onRequest?.call(RequestHookInfo(
        method: method,
        url: url,
        headers: headers,
        body: body,
        attempt: attempt,
      ));

      final startedAt = DateTime.now();
      TransportResponse response;
      try {
        response = await _transport.send(TransportRequest(
          method: method,
          url: url,
          headers: headers,
          body: serializedBody,
          timeout: timeout,
          responseType: options.responseType ?? ResponseType.json,
        ));
      } catch (error) {
        final retryable = error is NetworkError && error is! TimeoutError;
        if (retryable && attempt + 1 < maxAttempts) {
          final delay = backoffDelay(attempt, _retry);
          attempt += 1;
          await _hooks.onRetry?.call(RetryHookInfo(
            method: method,
            url: url,
            attempt: attempt,
            delay: delay,
            reason: error.message,
          ));
          await sleep(delay);
          continue;
        }
        throw ApiBrasilError.from(error);
      }

      await _hooks.onResponse?.call(ResponseHookInfo(
        method: method,
        url: url,
        status: response.status,
        duration: DateTime.now().difference(startedAt),
        attempt: attempt,
      ));

      if (response.status >= 400) {
        final error = createApiError(
          response.status,
          response.data,
          headers: response.headers,
        );
        final retryableStatus = _retry.retryOnStatuses.contains(response.status);
        if (retryableStatus && attempt + 1 < maxAttempts) {
          final delay = error is RateLimitError && error.retryAfter != null
              ? error.retryAfter!
              : backoffDelay(attempt, _retry);
          attempt += 1;
          await _hooks.onRetry?.call(RetryHookInfo(
            method: method,
            url: url,
            attempt: attempt,
            delay: delay,
            reason: 'HTTP ${response.status}',
          ));
          await sleep(delay);
          continue;
        }
        throw error;
      }

      return response.data;
    }
  }

  /// Executa a requisição e devolve o corpo como objeto JSON.
  ///
  /// Respostas vazias viram `{}`; respostas que não são objetos JSON
  /// (listas, texto) são embrulhadas em `{'data': ...}`.
  Future<Json> requestJson(
    HttpMethod method,
    String path, {
    Object? body,
    RequestOptions options = const RequestOptions(),
  }) async {
    final data = await request(method, path, body: body, options: options);
    return asJsonMap(data);
  }

  Future<Json> get(String path, [RequestOptions options = const RequestOptions()]) =>
      requestJson(HttpMethod.get, path, options: options);

  Future<Json> post(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      requestJson(HttpMethod.post, path, body: body, options: options);

  Future<Json> put(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      requestJson(HttpMethod.put, path, body: body, options: options);

  Future<Json> patch(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      requestJson(HttpMethod.patch, path, body: body, options: options);

  Future<Json> delete(
    String path, [
    Object? body,
    RequestOptions options = const RequestOptions(),
  ]) =>
      requestJson(HttpMethod.delete, path, body: body, options: options);

  /// Baixa o corpo cru (PDF de boleto, imagens...).
  Future<List<int>> bytes(
    HttpMethod method,
    String path, {
    Object? body,
    RequestOptions options = const RequestOptions(),
  }) async {
    final data = await request(
      method,
      path,
      body: body,
      options: options.copyWith(responseType: ResponseType.bytes),
    );
    if (data is List<int>) return data;
    if (data is String) return utf8.encode(data);
    return const <int>[];
  }
}

/// Normaliza o corpo decodificado em um objeto JSON.
Json asJsonMap(dynamic data) {
  if (data == null) return <String, dynamic>{};
  if (data is Json) return data;
  if (data is Map) return data.map((key, value) => MapEntry('$key', value));
  return <String, dynamic>{'data': data};
}

/// Monta a query string a partir de um mapa, ignorando valores nulos.
String buildQueryString(Map<String, Object?>? query) {
  if (query == null || query.isEmpty) return '';
  final parts = <String>[];
  for (final entry in query.entries) {
    final value = entry.value;
    if (value == null) continue;
    parts.add('${Uri.encodeQueryComponent(entry.key)}='
        '${Uri.encodeQueryComponent('$value')}');
  }
  return parts.isEmpty ? '' : '?${parts.join('&')}';
}

/// Junta a base da API com o caminho, sem barras duplicadas.
String joinUrl(String baseUrl, String path) {
  final base = baseUrl.replaceAll(RegExp(r'/+$'), '');
  final suffix = path.replaceAll(RegExp(r'^/+'), '');
  return suffix.isEmpty ? base : '$base/$suffix';
}
