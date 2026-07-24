import 'device_proxy_service.dart';
import '../core/types.dart';

/// GeoIP (`/database/ip`).
class DatabaseIpService extends DeviceProxyService {
  DatabaseIpService(super.http) : super(http, 'database');

  /// Consulta IP: `POST /database/ip`.
  Future<Json> ip(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('ip', body, options);
}