import 'device_proxy_service.dart';
import '../core/types.dart';

/// Geolocalização (`/geolocation/{action}`).
class GeolocationService extends DeviceProxyService {
  GeolocationService(super.http) : super(http, 'geolocation');

  /// Forward geocoding: `POST /geolocation/forward-geocoding`.
  Future<Json> forwardGeocoding(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('forward-geocoding', body, options);

  /// Geocode: `POST /geolocation/geocode`.
  Future<Json> geocode(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('geocode', body, options);
}

/// Matriz de distâncias (`/geomatrix/{action}`).
class GeomatrixService extends DeviceProxyService {
  GeomatrixService(super.http) : super(http, 'geomatrix');

  /// Distância: `POST /geomatrix/distance`.
  Future<Json> distance(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('distance', body, options);
}

/// OCR / Google Vision (`/recognize/{action}`).
class RecognizeService extends DeviceProxyService {
  RecognizeService(super.http) : super(http, 'recognize');

  /// Base64: `POST /recognize/base64`.
  Future<Json> base64(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('base64', body, options);

  /// URI: `POST /recognize/uri`.
  Future<Json> uri(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('uri', body, options);
}

/// DDD (`/ddd/{action}`).
class DddService extends DeviceProxyService {
  DddService(super.http) : super(http, 'ddd');
}

/// Feriados (`/holidays/{action}`).
class HolidaysService extends DeviceProxyService {
  HolidaysService(super.http) : super(http, 'holidays');

  /// Feriados: `POST /holidays/feriados`.
  Future<Json> feriados(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('feriados', body, options);
}

/// Tradução (`/translate/{action}`).
class TranslateService extends DeviceProxyService {
  TranslateService(super.http) : super(http, 'translate');

  /// Identify: `POST /translate/identify`.
  Future<Json> identify(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('identify', body, options);

  /// Models: `POST /translate/models`.
  Future<Json> models(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('models', body, options);
}

/// Clima (`/weather/{action}`).
class WeatherService extends DeviceProxyService {
  WeatherService(super.http) : super(http, 'weather');

  /// Cidade: `POST /weather/city`.
  Future<Json> city(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('city', body, options);

  /// Coordenadas: `POST /weather/coordenates`.
  Future<Json> coordenates(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('coordenates', body, options);
}

/// Loterias (`/loterias/{action}`).
class LoteriasService extends DeviceProxyService {
  LoteriasService(super.http) : super(http, 'loterias');

  /// Sorteio: `POST /loterias/{sorteio}`.
  Future<Json> sorteio(String sorteio, Json body, [RequestOptions options = const RequestOptions()]) =>
      request(sorteio, body, options);

  /// Último resultado: `POST /loterias/{sorteio}/latest`.
  Future<Json> latest(String sorteio, [Json? body, RequestOptions options = const RequestOptions()]) =>
      request('$sorteio/latest', body, options);
}