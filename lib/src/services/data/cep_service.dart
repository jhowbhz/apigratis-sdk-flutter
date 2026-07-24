import 'device_proxy_service.dart';
import '../core/types.dart';

/// CEP + geolocalização device-based (`/cep/{action}`).
/// Requires DeviceToken.
class CepService extends DeviceProxyService {
  CepService(super.http) : super(http, 'cep');

  /// Consulta CEP: `POST /cep/cep`.
  Future<Json> cep(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cep', body, options);

  /// Consulta bairros: `POST /cep/bairros`.
  Future<Json> bairros(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('bairros', body, options);

  /// Consulta cidades: `POST /cep/cidades`.
  Future<Json> cidades(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cidades', body, options);

  /// Consulta cidades por DDD: `POST /cep/cidadesPorDDD`.
  Future<Json> cidadesPorDdd(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cidadesPorDDD', body, options);

  /// Consulta estados: `POST /cep/estados`.
  Future<Json> estados([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('estados', body, options);

  /// Calcula distância: `POST /cep/distancia/calcular`.
  Future<Json> calcularDistancia(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('distancia/calcular', body, options);
}