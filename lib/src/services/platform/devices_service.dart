import '../base_service.dart';
import '../core/types.dart';

/// Gestão de devices (`/devices/{action}`).
class DevicesService extends BaseService {
  DevicesService(super.http);

  /// Lista devices: `GET /devices`.
  Future<Json> list([RequestOptions options = const RequestOptions()]) =>
      http.get('devices', options);

  /// Cria device: `POST /devices`.
  Future<Json> create(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('devices', body, options);

  /// Busca device: `GET /devices/{id}`.
  Future<Json> get(String id, [RequestOptions options = const RequestOptions()]) =>
      http.get('devices/$id', options);

  /// Atualiza device: `PUT /devices/{id}`.
  Future<Json> update(String id, Json body, [RequestOptions options = const RequestOptions()]) =>
      http.put('devices/$id', body, options);

  /// Remove device: `DELETE /devices/{id}`.
  Future<Json> delete(String id, [RequestOptions options = const RequestOptions()]) =>
      http.delete('devices/$id', options);

  /// Requisições do device: `GET /devices/{id}/requests`.
  Future<Json> requests(String id, [RequestOptions options = const RequestOptions()]) =>
      http.get('devices/$id/requests', options);

  /// Solicitações paginadas: `GET /requests/paginate`.
  Future<Json> paginateRequests([RequestOptions options = const RequestOptions()]) =>
      http.get('requests/paginate', options);
}