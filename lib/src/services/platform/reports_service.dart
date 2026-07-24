import '../base_service.dart';
import '../../core/types.dart';

/// Relatórios e dashboard de consumo (`/reports/{action}`).
class ReportsService extends BaseService {
  ReportsService(super.http);

  /// Dashboard: `GET /reports/dashboard`.
  Future<Json> dashboard([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/dashboard', options);

  /// Consumo por serviço: `GET /reports/consumption`.
  Future<Json> consumption([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/consumption', options);

  /// Consumo por device: `GET /reports/consumption/device`.
  Future<Json> consumptionByDevice([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/consumption/device', options);

  /// Consumo por endpoint: `GET /reports/consumption/endpoint`.
  Future<Json> consumptionByEndpoint([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/consumption/endpoint', options);

  /// Erros: `GET /reports/errors`.
  Future<Json> errors([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/errors', options);

  /// Latência: `GET /reports/latency`.
  Future<Json> latency([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/latency', options);

  /// Exporta relatório: `POST /reports/export`.
  Future<Json> export(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('reports/export', body, options);

  /// Webhooks: `GET /reports/webhooks`.
  Future<Json> webhooks([RequestOptions options = const RequestOptions()]) =>
      http.get('reports/webhooks', options);
}
