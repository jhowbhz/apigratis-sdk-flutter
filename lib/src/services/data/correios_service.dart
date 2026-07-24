import '../base_service.dart';
import '../../core/types.dart';

/// Correios (`/correios/{action}`).
class CorreiosService extends BaseService {
  CorreiosService(super.http);

  /// Rastreio: `POST /correios/rastreio` body `{'code': '...'}`.
  Future<Json> rastreio(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('correios/rastreio', body, options);
}
