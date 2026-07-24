import 'base_service.dart';
import '../core/types.dart';

/// Base service for device-based APIs (WhatsApp, SMS, Evolution, WhatsMeow, CEP, etc.).
/// These endpoints require `DeviceToken` header and use the pattern `POST /{service}/{action}`.
class DeviceProxyService extends BaseService {
  DeviceProxyService(super.http, this.serviceName);

  /// The service name (e.g., 'whatsapp', 'sms', 'cep', 'evolution', 'whatsmeow').
  final String serviceName;

  /// Executes an action on this service.
  ///
  /// [action] - The action name (e.g., 'sendText', 'start', 'cep').
  /// [body] - Request body as a Map.
  /// [options] - Optional request options (custom headers, timeout, etc.).
  Future<Json> request(
    String action, [
    Json? body,
    RequestOptions options = const RequestOptions(),
  ]) {
    final path = '$serviceName/$action';
    return post(path, body, options);
  }

  /// Executes an action asynchronously via queue (for supported actions).
  ///
  /// Uses `POST /{service}/{action}/queue`.
  Future<Json> queue(
    String action, [
    Json? body,
    RequestOptions options = const RequestOptions(),
  ]) {
    final path = '$serviceName/$action/queue';
    return post(path, body, options);
  }
}
