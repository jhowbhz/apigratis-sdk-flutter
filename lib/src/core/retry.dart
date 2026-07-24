import 'dart:math';

import 'types.dart';

/// Política de retry padrão: 2 novas tentativas, backoff de 300ms a 5s,
/// apenas em HTTP 429 e falhas de conexão.
const RetryConfig defaultRetry = RetryConfig();

final Random _random = Random();

/// Resolve a política efetiva — `null` usa [defaultRetry].
RetryConfig resolveRetry(RetryConfig? config) => config ?? defaultRetry;

/// Backoff exponencial com jitter: `minDelay * 2^attempt`, limitado a
/// `maxDelay`.
Duration backoffDelay(int attempt, RetryConfig retry, {Random? random}) {
  final exponential = retry.minDelay.inMilliseconds * pow(2, attempt);
  final jitter = 0.5 + (random ?? _random).nextDouble() * 0.5;
  final delayMs = (exponential * jitter).round();
  return delayMs >= retry.maxDelay.inMilliseconds
      ? retry.maxDelay
      : Duration(milliseconds: delayMs);
}

/// Aguarda [delay] — ponto de extensão para testes.
Future<void> sleep(Duration delay) => Future<void>.delayed(delay);
