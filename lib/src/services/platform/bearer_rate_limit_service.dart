import '../base_service.dart';
import '../../core/types.dart';

/// Rate limit por Bearer Token (`/bearer-rate-limit/{action}`).
class BearerRateLimitService extends BaseService {
  BearerRateLimitService(super.http);

  /// Consulta: `GET /bearer-rate-limit`.
  Future<Json> show([RequestOptions options = const RequestOptions()]) =>
      http.get('bearer-rate-limit', options);

  /// Atualiza: `PUT /bearer-rate-limit`.
  Future<Json> update(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.put('bearer-rate-limit', body, options);
}
