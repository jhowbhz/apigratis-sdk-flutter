import '../base_service.dart';
import '../core/types.dart';

/// Catálogo de APIs, planos, docs e servidores (`/apis`, `/plan`, `/servers`, `/catalog`).
class CatalogService extends BaseService {
  CatalogService(super.http);

  /// Lista APIs: `GET /apis/list`.
  Future<Json> listApis([RequestOptions options = const RequestOptions()]) =>
      http.get('apis/list', options);

  /// Detalhes de API: `GET /apis/{slug}`.
  Future<Json> apiDetails(String slug, [RequestOptions options = const RequestOptions()]) =>
      http.get('apis/$slug', options);

  /// Planos: `GET /plan`.
  Future<Json> plans([RequestOptions options = const RequestOptions()]) =>
      http.get('plan', options);

  /// Plano atual: `GET /plan/current`.
  Future<Json> currentPlan([RequestOptions options = const RequestOptions()]) =>
      http.get('plan/current', options);

  /// Servidores: `GET /servers`.
  Future<Json> servers([RequestOptions options = const RequestOptions()]) =>
      http.get('servers', options);

  /// Documentações: `GET /catalog/docs`.
  Future<Json> docs([RequestOptions options = const RequestOptions()]) =>
      http.get('catalog/docs', options);

  /// Documentação específica: `GET /catalog/docs/{slug}`.
  Future<Json> docDetails(String slug, [RequestOptions options = const RequestOptions()]) =>
      http.get('catalog/docs/$slug', options);

  /// Catálogo completo: `GET /catalog`.
  Future<Json> catalog([RequestOptions options = const RequestOptions()]) =>
      http.get('catalog', options);
}