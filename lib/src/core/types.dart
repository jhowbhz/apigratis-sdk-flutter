import 'dart:async';

import 'transport.dart';

/// Objeto JSON decodificado — o formato de resposta da maioria das rotas.
typedef Json = Map<String, dynamic>;

/// Métodos HTTP usados pelo gateway.
enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  const HttpMethod(this.value);

  /// Verbo HTTP como enviado na requisição (ex: `POST`).
  final String value;
}

/// Como o corpo da resposta deve ser decodificado.
enum ResponseType {
  /// Decodifica JSON (padrão). Corpos não-JSON voltam como [String].
  json,

  /// Devolve os bytes crus — use para PDFs, imagens etc.
  bytes,
}

/// Política de retry do cliente. Por padrão a SDK tenta novamente apenas
/// em HTTP 429 (rate limit) e em falhas de conexão — nunca em timeouts ou
/// erros de negócio, para não duplicar cobranças/envios.
class RetryConfig {
  const RetryConfig({
    this.retries = 2,
    this.minDelay = const Duration(milliseconds: 300),
    this.maxDelay = const Duration(seconds: 5),
    this.retryOnStatuses = const [429],
  });

  /// Número de novas tentativas além da original. Padrão: 2.
  final int retries;

  /// Atraso base do backoff exponencial. Padrão: 300ms.
  final Duration minDelay;

  /// Teto do atraso entre tentativas. Padrão: 5s.
  final Duration maxDelay;

  /// Status HTTP que disparam retry. Padrão: `[429]`.
  final List<int> retryOnStatuses;

  /// Desliga o retry — passe em [ApiBrasilConfig.retry].
  static const RetryConfig disabled = RetryConfig(retries: 0);

  RetryConfig copyWith({
    int? retries,
    Duration? minDelay,
    Duration? maxDelay,
    List<int>? retryOnStatuses,
  }) {
    return RetryConfig(
      retries: retries ?? this.retries,
      minDelay: minDelay ?? this.minDelay,
      maxDelay: maxDelay ?? this.maxDelay,
      retryOnStatuses: retryOnStatuses ?? this.retryOnStatuses,
    );
  }
}

/// Dados da requisição entregues ao hook [ApiBrasilHooks.onRequest].
class RequestHookInfo {
  const RequestHookInfo({
    required this.method,
    required this.url,
    required this.headers,
    required this.attempt,
    this.body,
  });

  final HttpMethod method;
  final String url;
  final Map<String, String> headers;
  final Object? body;

  /// Tentativa atual (0 = primeira).
  final int attempt;
}

/// Dados da resposta entregues ao hook [ApiBrasilHooks.onResponse].
class ResponseHookInfo {
  const ResponseHookInfo({
    required this.method,
    required this.url,
    required this.status,
    required this.duration,
    required this.attempt,
  });

  final HttpMethod method;
  final String url;
  final int status;
  final Duration duration;
  final int attempt;
}

/// Dados do retry entregues ao hook [ApiBrasilHooks.onRetry].
class RetryHookInfo {
  const RetryHookInfo({
    required this.method,
    required this.url,
    required this.attempt,
    required this.delay,
    required this.reason,
  });

  final HttpMethod method;
  final String url;

  /// Número da próxima tentativa.
  final int attempt;
  final Duration delay;
  final String reason;
}

/// Hooks de observabilidade — logging, métricas, tracing.
class ApiBrasilHooks {
  const ApiBrasilHooks({this.onRequest, this.onResponse, this.onRetry});

  final FutureOr<void> Function(RequestHookInfo info)? onRequest;
  final FutureOr<void> Function(ResponseHookInfo info)? onResponse;
  final FutureOr<void> Function(RetryHookInfo info)? onRetry;
}

/// Configuração do cliente `ApiBrasil`.
///
/// Campos não informados são lidos das variáveis de ambiente
/// `APIBRASIL_BEARER_TOKEN`, `APIBRASIL_DEVICE_TOKEN`,
/// `APIBRASIL_SECRET_KEY` e `APIBRASIL_BASE_URL`.
class ApiBrasilConfig {
  const ApiBrasilConfig({
    this.bearerToken,
    this.deviceToken,
    this.secretKey,
    this.baseUrl,
    this.timeout,
    this.headers,
    this.transport,
    this.retry,
    this.hooks,
  });

  /// Token JWT obtido no login (`Authorization: Bearer <token>`).
  final String? bearerToken;

  /// Token do dispositivo, exigido pelos serviços device-based
  /// (WhatsApp, SMS, veículos...).
  final String? deviceToken;

  /// SecretKey da API (usada apenas na criação de devices).
  final String? secretKey;

  /// Base da API. Padrão: `https://gateway.apibrasil.io/api/v2`.
  final String? baseUrl;

  /// Timeout das requisições. Padrão: 30s.
  final Duration? timeout;

  /// Headers adicionais enviados em todas as requisições.
  final Map<String, String>? headers;

  /// Transporte HTTP customizado. Padrão: [HttpTransport] (package:http).
  final Transport? transport;

  /// Política de retry. Passe [RetryConfig.disabled] para desativar.
  final RetryConfig? retry;

  /// Hooks de observabilidade.
  final ApiBrasilHooks? hooks;

  /// Devolve uma cópia com os campos informados sobrescritos.
  ApiBrasilConfig copyWith({
    String? bearerToken,
    String? deviceToken,
    String? secretKey,
    String? baseUrl,
    Duration? timeout,
    Map<String, String>? headers,
    Transport? transport,
    RetryConfig? retry,
    ApiBrasilHooks? hooks,
  }) {
    return ApiBrasilConfig(
      bearerToken: bearerToken ?? this.bearerToken,
      deviceToken: deviceToken ?? this.deviceToken,
      secretKey: secretKey ?? this.secretKey,
      baseUrl: baseUrl ?? this.baseUrl,
      timeout: timeout ?? this.timeout,
      headers: headers ?? this.headers,
      transport: transport ?? this.transport,
      retry: retry ?? this.retry,
      hooks: hooks ?? this.hooks,
    );
  }

  /// Sobrepõe esta configuração com [other] — os campos definidos em
  /// [other] têm prioridade.
  ApiBrasilConfig merge(ApiBrasilConfig other) {
    return copyWith(
      bearerToken: other.bearerToken,
      deviceToken: other.deviceToken,
      secretKey: other.secretKey,
      baseUrl: other.baseUrl,
      timeout: other.timeout,
      headers: other.headers,
      transport: other.transport,
      retry: other.retry,
      hooks: other.hooks,
    );
  }
}

/// Opções por requisição — sobrescrevem a configuração do cliente.
class RequestOptions {
  const RequestOptions({
    this.query,
    this.headers,
    this.bearerToken,
    this.deviceToken,
    this.secretKey,
    this.timeout,
    this.responseType,
  });

  /// Query string da requisição. Valores `null` são ignorados.
  final Map<String, Object?>? query;

  /// Headers extras desta requisição.
  final Map<String, String>? headers;

  final String? bearerToken;
  final String? deviceToken;
  final String? secretKey;
  final Duration? timeout;

  /// Como decodificar a resposta. Padrão: [ResponseType.json].
  final ResponseType? responseType;

  RequestOptions copyWith({
    Map<String, Object?>? query,
    Map<String, String>? headers,
    String? bearerToken,
    String? deviceToken,
    String? secretKey,
    Duration? timeout,
    ResponseType? responseType,
  }) {
    return RequestOptions(
      query: query ?? this.query,
      headers: headers ?? this.headers,
      bearerToken: bearerToken ?? this.bearerToken,
      deviceToken: deviceToken ?? this.deviceToken,
      secretKey: secretKey ?? this.secretKey,
      timeout: timeout ?? this.timeout,
      responseType: responseType ?? this.responseType,
    );
  }

  /// Mescla [query] mantendo as chaves já definidas nesta instância.
  RequestOptions withQuery(Map<String, Object?> extra) {
    return copyWith(query: {...extra, ...?query});
  }
}

/// Envelope de resposta dos serviços device-based
/// (`{ error, message, response, api_limit... }`).
///
/// É um `Map<String, dynamic>` em tempo de execução — use os getters
/// tipados ou o acesso por chave (`res['response']`), como preferir.
extension type DeviceServiceResponse(Json json) implements Json {
  /// `true` quando o gateway sinalizou erro no envelope.
  bool get isError => json['error'] == true;

  /// Mensagem devolvida pelo gateway.
  String? get message => json['message'] as String?;

  /// Payload do provedor (`response`).
  dynamic get response => json['response'];

  /// Limite de requisições do plano.
  Object? get apiLimit => json['api_limit'];

  /// Janela do limite (ex: `day`).
  Object? get apiLimitFor => json['api_limit_for'];

  /// Quanto do limite já foi consumido.
  Object? get apiLimitUsed => json['api_limit_used'];
}

/// Envelope de resposta das consultas por crédito
/// (`{ error, message, balance, tax, valor_consulta, data... }`).
///
/// É um `Map<String, dynamic>` em tempo de execução — use os getters
/// tipados ou o acesso por chave (`res['data']`), como preferir.
extension type CreditServiceResponse(Json json) implements Json {
  /// `true` quando o gateway sinalizou erro no envelope.
  bool get isError => json['error'] == true;

  /// Mensagem devolvida pelo gateway.
  String? get message => json['message'] as String?;

  /// Saldo restante após a consulta.
  Object? get balance => json['balance'];

  /// Taxa aplicada.
  Object? get tax => json['tax'];

  /// Valor cobrado pela consulta.
  Object? get valorConsulta => json['valor_consulta'];

  /// `true` quando a resposta veio do modo homologação.
  bool get homolog => json['homolog'] == true;

  /// Dados da consulta.
  dynamic get data => json['data'];
}

/// Campos comuns aceitos pelas consultas por crédito
/// (`/consulta/{service}/credits`).
///
/// Aceita qualquer chave extra — o gateway define os campos por produto.
/// Veja `Catalog.consultaTipos` para os tipos conhecidos.
Json consultaPayload({
  String? tipo,
  bool? homolog,
  bool? lite,
  List<String>? agrupados,
  List<String>? extra,
  Json? fields,
}) {
  return {
    if (tipo != null) 'tipo': tipo,
    if (homolog != null) 'homolog': homolog,
    if (lite != null) 'lite': lite,
    if (agrupados != null) 'agrupados': agrupados,
    if (extra != null) 'extra': extra,
    ...?fields,
  };
}
