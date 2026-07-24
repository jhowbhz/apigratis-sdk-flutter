import 'device_proxy_service.dart';
import '../core/types.dart';

/// Feriados (`/holidays/{action}`).
/// Device-based (requires DeviceToken).
class HolidaysService extends DeviceProxyService {
  HolidaysService(super.http) : super(http, 'holidays');

  /// Consulta feriados: `POST /holidays/feriados`.
  Future<Json> feriados(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('feriados', body, options);
}