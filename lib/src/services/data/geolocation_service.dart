import '../device_proxy_service.dart';
import '../../core/http_client.dart';
import '../../core/types.dart';

/// Geolocalização (`/geolocation/{action}`).
/// Device-based (requires DeviceToken).
class GeolocationService extends DeviceProxyService {
  GeolocationService(ApiHttpClient http) : super(http, 'geolocation');

  /// Geocode: `POST /geolocation/geocode`.
  Future<Json> geocode(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('geocode', body, options);

  /// Forward geocoding: `POST /geolocation/forward-geocoding`.
  Future<Json> forwardGeocoding(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('forward-geocoding', body, options);
}
