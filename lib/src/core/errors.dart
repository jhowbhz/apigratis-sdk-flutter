/// Erro base lançado pelo cliente `ApiBrasil`. Subclasses específicas
/// permitem tratar cada categoria com `is`:
///
/// - [ValidationError] (400/422), [AuthenticationError] (401),
///   [InsufficientBalanceError] (402), [PermissionError] (403),
///   [NotFoundError] (404/410), [RateLimitError] (429), [ServerError] (5xx)
/// - [NetworkError] / [TimeoutError] para falhas antes da resposta.
class ApiBrasilError implements Exception {
  ApiBrasilError(this.message, {this.status, this.code, this.response, this.cause});

  /// Mensagem de erro — a da API quando disponível.
  final String message;

  /// Status HTTP retornado pela API (ex: 401, 402, 404).
  final int? status;

  /// Código de erro retornado pela API (ex: `NOT_FOUND`).
  final String? code;

  /// Corpo completo da resposta de erro, quando existir.
  final dynamic response;

  /// Erro original que causou esta falha, quando houver.
  final Object? cause;

  /// `true` quando a falha foi por saldo/créditos insuficientes (HTTP 402).
  bool get isInsufficientBalance => status == 402;

  /// `true` quando a falha foi de autenticação (HTTP 401).
  bool get isUnauthorized => status == 401;

  /// Converte qualquer erro em um [ApiBrasilError].
  static ApiBrasilError from(Object error) {
    if (error is ApiBrasilError) return error;
    return ApiBrasilError(
      error is Exception || error is Error ? error.toString() : '$error',
      cause: error,
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer(runtimeType.toString())
      ..write(': ')
      ..write(message);
    if (status != null) buffer.write(' (HTTP $status)');
    if (code != null) buffer.write(' [$code]');
    return buffer.toString();
  }
}

/// Falha de rede — a requisição pode não ter chegado ao servidor.
class NetworkError extends ApiBrasilError {
  NetworkError(super.message, {super.status, super.code, super.response, super.cause});
}

/// Timeout — a requisição pode ter sido processada; a SDK não faz retry
/// automático para não duplicar cobranças/envios.
class TimeoutError extends NetworkError {
  TimeoutError(super.message, {super.status, super.code, super.response, super.cause});
}

/// HTTP 400/422 — payload inválido.
class ValidationError extends ApiBrasilError {
  ValidationError(super.message, {super.status, super.code, super.response, super.cause});
}

/// HTTP 401 — Bearer Token ausente, inválido ou expirado.
class AuthenticationError extends ApiBrasilError {
  AuthenticationError(super.message, {super.status, super.code, super.response, super.cause});
}

/// HTTP 402 — saldo/créditos insuficientes.
class InsufficientBalanceError extends ApiBrasilError {
  InsufficientBalanceError(super.message, {super.status, super.code, super.response, super.cause});
}

/// HTTP 403 — sem permissão (ex: API exige conta PJ).
class PermissionError extends ApiBrasilError {
  PermissionError(super.message, {super.status, super.code, super.response, super.cause});
}

/// HTTP 404/410 — recurso não encontrado ou desativado.
class NotFoundError extends ApiBrasilError {
  NotFoundError(super.message, {super.status, super.code, super.response, super.cause});
}

/// HTTP 429 — rate limit atingido.
class RateLimitError extends ApiBrasilError {
  RateLimitError(
    super.message, {
    super.status,
    super.code,
    super.response,
    super.cause,
    this.retryAfter,
  });

  /// Espera sugerida pelo servidor (header `Retry-After`).
  final Duration? retryAfter;
}

/// HTTP 5xx — erro interno do gateway/provedor.
class ServerError extends ApiBrasilError {
  ServerError(super.message, {super.status, super.code, super.response, super.cause});
}

String _extractMessage(int status, dynamic data) {
  if (data is Map) {
    final message = data['message'];
    if (message is String && message.isNotEmpty) return message;
    final error = data['error'];
    if (error is String && error.isNotEmpty) return error;
  }
  return 'A API respondeu com HTTP $status.';
}

String? _extractCode(dynamic data) {
  if (data is Map) {
    final code = data['code'];
    if (code is String && code.isNotEmpty) return code;
  }
  return null;
}

/// Lê o header `Retry-After` (segundos ou data HTTP).
Duration? parseRetryAfter(Map<String, String>? headers, {DateTime? now}) {
  if (headers == null) return null;
  String? raw;
  for (final entry in headers.entries) {
    if (entry.key.toLowerCase() == 'retry-after') {
      raw = entry.value;
      break;
    }
  }
  if (raw == null || raw.isEmpty) return null;

  final seconds = num.tryParse(raw.trim());
  if (seconds != null) {
    return Duration(milliseconds: (seconds * 1000).round().clamp(0, 1 << 31));
  }

  final at = DateTime.tryParse(raw);
  if (at == null) return null;
  final delta = at.difference(now ?? DateTime.now());
  return delta.isNegative ? Duration.zero : delta;
}

/// Mapeia um status HTTP + corpo de erro para a subclasse adequada.
ApiBrasilError createApiError(
  int status,
  dynamic data, {
  Map<String, String>? headers,
  Object? cause,
}) {
  final message = _extractMessage(status, data);
  final code = _extractCode(data);

  if (status == 400 || status == 422) {
    return ValidationError(message, status: status, code: code, response: data, cause: cause);
  }
  if (status == 401) {
    return AuthenticationError(message, status: status, code: code, response: data, cause: cause);
  }
  if (status == 402) {
    return InsufficientBalanceError(message,
        status: status, code: code, response: data, cause: cause);
  }
  if (status == 403) {
    return PermissionError(message, status: status, code: code, response: data, cause: cause);
  }
  if (status == 404 || status == 410) {
    return NotFoundError(message, status: status, code: code, response: data, cause: cause);
  }
  if (status == 429) {
    return RateLimitError(
      message,
      status: status,
      code: code,
      response: data,
      cause: cause,
      retryAfter: parseRetryAfter(headers),
    );
  }
  if (status >= 500) {
    return ServerError(message, status: status, code: code, response: data, cause: cause);
  }
  return ApiBrasilError(message, status: status, code: code, response: data, cause: cause);
}
