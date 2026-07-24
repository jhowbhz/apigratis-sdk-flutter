import 'device_proxy_service.dart';
import '../core/types.dart';

/// DDD (`/ddd/{action}`).
/// Device-based (requires DeviceToken).
class DddService extends DeviceProxyService {
  DddService(super.http) : super(http, 'ddd');

  // Actions are dynamic - use request() directly
}