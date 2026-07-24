import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'errors.dart';
import 'types.dart';

/// Requisição entregue à camada de [Transport].
class TransportRequest {
  const TransportRequest({
    required this.method,
    required this.url,
    required this.headers,
    this.body,
    this.timeout,
    this.responseType = ResponseType.json,
  });

  final HttpMethod method;

  /// URL absoluta, já com query string.
  final String url;

  final Map<String, String> headers;

  /// Corpo já serializado (JSON).
  final String? body;

  final Duration? timeout;

  final ResponseType responseType;
}

/// Resposta devolvida pela camada de [Transport].
class TransportResponse {
  const TransportResponse({
    required this.status,
    required this.data,
    this.headers = const {},
  });

  final int status;

  /// Headers da resposta, com as chaves em minúsculas.
  final Map<String, String> headers;

  /// Corpo já decodificado (JSON → Map/List; texto; bytes).
  final dynamic data;
}

/// Camada de transporte HTTP da SDK. A implementação padrão usa
/// `package:http` ([HttpTransport]); injete a sua para usar Dio, proxies,
/// mocks de teste etc.
///
/// Contrato: resolve com a resposta para QUALQUER status HTTP; lança
/// [NetworkError]/[TimeoutError] apenas quando não houve resposta.
abstract interface class Transport {
  Future<TransportResponse> send(TransportRequest request);

  /// Libera os recursos do transporte (conexões abertas).
  void close();
}

/// Transporte padrão, baseado em `package:http` — funciona em Flutter
/// (Android, iOS, web, desktop) e em Dart puro.
class HttpTransport implements Transport {
  HttpTransport({http.Client? client, bool closeClient = true})
      : _client = client ?? http.Client(),
        _closeClient = client == null || closeClient;

  final http.Client _client;
  final bool _closeClient;

  @override
  Future<TransportResponse> send(TransportRequest request) async {
    final uri = Uri.parse(request.url);
    final httpRequest = http.Request(request.method.value, uri);
    httpRequest.headers.addAll(request.headers);
    if (request.body != null) {
      httpRequest.bodyBytes = utf8.encode(request.body!);
    }

    http.Response response;
    try {
      Future<http.Response> exchange() async {
        final streamed = await _client.send(httpRequest);
        return http.Response.fromStream(streamed);
      }

      final timeout = request.timeout;
      response = timeout != null && timeout > Duration.zero
          ? await exchange().timeout(timeout)
          : await exchange();
    } on TimeoutException catch (error) {
      throw TimeoutError(
        'Tempo limite de ${request.timeout?.inMilliseconds}ms excedido em '
        '${request.method.value} ${request.url}.',
        cause: error,
      );
    } catch (error) {
      throw NetworkError(
        'Falha de rede em ${request.method.value} ${request.url}: $error',
        cause: error,
      );
    }

    return TransportResponse(
      status: response.statusCode,
      headers: response.headers,
      data: decodeBody(response.bodyBytes, request.responseType),
    );
  }

  @override
  void close() {
    if (_closeClient) _client.close();
  }
}

/// Decodifica o corpo conforme o [ResponseType] pedido.
///
/// Em [ResponseType.json] o corpo é lido sempre como UTF-8 (o gateway nem
/// sempre declara o charset, e o padrão do `package:http` estragaria os
/// acentos) e, se não for JSON válido, volta como texto.
dynamic decodeBody(List<int> bytes, ResponseType responseType) {
  if (responseType == ResponseType.bytes) return bytes;
  if (bytes.isEmpty) return null;

  final text = utf8.decode(bytes, allowMalformed: true);
  if (text.trim().isEmpty) return null;
  try {
    return jsonDecode(text);
  } on FormatException {
    return text;
  }
}
