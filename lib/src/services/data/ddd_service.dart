import '../../core/http_client.dart';
import '../device_proxy_service.dart';

/// DDD (`/ddd/{action}`).
/// Device-based (requires DeviceToken).
class DddService extends DeviceProxyService {
  DddService(ApiHttpClient http) : super(http, 'ddd');

  // Actions are dynamic - use request() directly
}
