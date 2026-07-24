import 'device_proxy_service.dart';
import '../core/types.dart';

/// Matriz de distâncias (`/geomatrix/{action}`).
/// Device-based (requires DeviceToken).
class GeomatrixService extends DeviceProxyService {
  GeomatrixService(super.http) : super(http, 'geomatrix');

  /// Calcula distância: `POST /geomatrix/distance`.
  Future<Json> distance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('distance', body, options);
}