import '../device_proxy_service.dart';
import '../../core/http_client.dart';
import '../../core/types.dart';

/// Dados cadastrais device-based (`/dados/{action}`): CPF, CNPJ, lista sócios, CNAEs, etc.
class DadosService extends DeviceProxyService {
  DadosService(ApiHttpClient http) : super(http, 'dados');

  /// Consulta CPF: `POST /dados/cpf` body `{'cpf': '...'}`.
  Future<Json> cpf(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cpf', body, options);

  /// Consulta CNPJ: `POST /dados/cnpj` body `{'cnpj': '...'}`.
  Future<Json> cnpj(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cnpj', body, options);

  /// Consulta por query: `POST /dados/byquery`.
  Future<Json> byQuery(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('byquery', body, options);

  /// Capital social: `POST /dados/capital-social`.
  Future<Json> capitalSocial(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('capital-social', body, options);

  /// Lista CNAEs: `POST /dados/lista-cnaes`.
  Future<Json> listaCnaes([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('lista-cnaes', body, options);

  /// Lista sócios: `POST /dados/lista-socios`.
  Future<Json> listaSocios(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('lista-socios', body, options);

  /// Consulta UF: `POST /dados/uf`.
  Future<Json> uf(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('uf', body, options);

  /// Consulta CEP: `POST /dados/cep`.
  Future<Json> cep(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cep', body, options);

  /// Créditos CPF: `GET /dados/cpf/credits`.
  Future<Json> cpfCredits([RequestOptions options = const RequestOptions()]) =>
      http.get('dados/cpf/credits', options);

  /// Créditos CNPJ: `GET /dados/cnpj/credits`.
  Future<Json> cnpjCredits([RequestOptions options = const RequestOptions()]) =>
      http.get('dados/cnpj/credits', options);
}
