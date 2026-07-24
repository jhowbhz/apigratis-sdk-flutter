import '../device_proxy_service.dart';
import '../../core/http_client.dart';
import '../../core/types.dart';

/// Feriados (`/holidays/{action}`).
/// Device-based (requires DeviceToken).
class HolidaysService extends DeviceProxyService {
  HolidaysService(ApiHttpClient http) : super(http, 'holidays');

  /// Consulta feriados: `POST /holidays/feriados`.
  Future<Json> feriados(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('feriados', body, options);
}
