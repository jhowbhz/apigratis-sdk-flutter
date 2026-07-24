import 'device_proxy_service.dart';
import '../core/types.dart';

/// SMS device-based API (`POST /sms/{action}` and `/sms/send/credits`).
/// Requires `Authorization: Bearer` + `DeviceToken`.
class SmsService extends DeviceProxyService {
  SmsService(super.http) : super(http, 'sms');

  /// Sends an SMS via device: `POST /sms/send`.
  /// Fields: `number`, `message`, `operator`, `user_reply`, `webhook_url`.
  Future<Json> send(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send', body, options);

  /// Sends an SMS debiting credits from account (no DeviceToken): `POST /sms/send/credits`.
  Future<Json> sendWithCredits(Json body, [RequestOptions options = const RequestOptions()]) {
    final path = 'sms/send/credits';
    return http.post(path, body, options);
  }

  /// Sends an SMS via queue (async): `POST /sms/send/queue`.
  Future<Json> queue(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('send/queue', body, options);
}