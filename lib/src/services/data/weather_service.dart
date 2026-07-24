import 'device_proxy_service.dart';
import '../core/types.dart';

/// Clima (`/weather/{action}`).
/// Device-based (requires DeviceToken).
class WeatherService extends DeviceProxyService {
  WeatherService(super.http) : super(http, 'weather');

  /// Por cidade: `POST /weather/city`.
  Future<Json> city(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('city', body, options);

  /// Por coordenadas: `POST /weather/coordenates`.
  Future<Json> coordenates(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('coordenates', body, options);
}