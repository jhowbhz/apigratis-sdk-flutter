import '../device_proxy_service.dart';
import '../../core/http_client.dart';
import '../../core/types.dart';

/// Veículos por placa (`/vehicles/{action}` e `/vehicles/fipe`).
class VehiclesService extends DeviceProxyService {
  VehiclesService(ApiHttpClient http) : super(http, 'vehicles');

  /// Dados do veículo: `POST /vehicles/dados` body `{'placa': '...'}`.
  Future<Json> dados(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('dados', body, options);

  /// FIPE: `POST /vehicles/fipe` body `{'placa': '...'}`.
  Future<Json> fipe(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('fipe', body, options);

  /// Base nacional: `POST /vehicles/base/000/dados` (endpoint especial).
  Future<Json> baseDados(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('base/000/dados', body, options);
}
