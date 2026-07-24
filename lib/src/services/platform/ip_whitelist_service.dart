import '../base_service.dart';
import '../core/types.dart';

/// IP Whitelist da conta (`/ip-whitelist/{action}`).
class IpWhitelistService extends BaseService {
  IpWhitelistService(super.http);

  /// Lista IPs: `GET /ip-whitelist`.
  Future<Json> list([RequestOptions options = const RequestOptions()]) =>
      http.get('ip-whitelist', options);

  /// Adiciona IP: `POST /ip-whitelist`.
  Future<Json> add(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('ip-whitelist', body, options);

  /// Remove IP: `DELETE /ip-whitelist/{id}`.
  Future<Json> remove(String id, [RequestOptions options = const RequestOptions()]) =>
      http.delete('ip-whitelist/$id', options);
}