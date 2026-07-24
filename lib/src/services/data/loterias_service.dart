import '../base_service.dart';
import '../../core/types.dart';

/// Loterias (`/loterias/{action}`).
/// Device-based (requires DeviceToken).
class LoteriasService extends BaseService {
  LoteriasService(super.http);

  /// Resultado por sorteio e concurso: `POST /loterias/:sorteio/:concurso`.
  Future<Json> resultado(String sorteio, int concurso,
          [Json? body, RequestOptions options = const RequestOptions()]) =>
      http.post('loterias/$sorteio/$concurso', body, options);

  /// Último resultado: `POST /loterias/:sorteio/latest`.
  Future<Json> latest(String sorteio,
          [Json? body, RequestOptions options = const RequestOptions()]) =>
      http.post('loterias/$sorteio/latest', body, options);
}
