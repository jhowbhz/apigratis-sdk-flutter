import '../base_service.dart';
import '../../core/types.dart';

/// Execução em lote (`/bulk/*`).
class BulkService extends BaseService {
  BulkService(super.http);

  /// Cria job em lote: `POST /bulk`.
  Future<Json> create(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('bulk', body, options);

  /// Status do job: `GET /bulk/{id}`.
  Future<Json> status(String id, [RequestOptions options = const RequestOptions()]) =>
      http.get('bulk/$id', options);

  /// Lista jobs: `GET /bulk`.
  Future<Json> list([RequestOptions options = const RequestOptions()]) => http.get('bulk', options);
}
