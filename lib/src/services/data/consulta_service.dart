import '../base_service.dart';
import '../core/types.dart';

/// Consultas por crédito (`/consulta/{service}/credits`).
/// Requires `Authorization: Bearer` (no DeviceToken).
class ConsultaService extends BaseService {
  ConsultaService(super.http);

  /// Executa uma consulta: `POST /consulta/{service}/credits`.
  Future<Json> request(
    String service,
    Json body, [
    RequestOptions options = const RequestOptions(),
  ]) =>
      http.post('consulta/$service/credits', body, options);

  /// Consulta CPF: `POST /consulta/cpf/credits`.
  Future<Json> cpf(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cpf', body, options);

  /// Consulta CNPJ: `POST /consulta/cnpj/credits`.
  Future<Json> cnpj(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cnpj', body, options);

  /// Consulta CEP: `POST /consulta/cep/credits`.
  Future<Json> cep(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cep', body, options);

  /// Consulta Veículos: `POST /consulta/vehicles/credits` ou `/consulta/veiculos/credits`.
  Future<Json> vehicles(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('vehicles', body, options);

  /// Consulta Veículos (PT-BR): `POST /consulta/veiculos/credits`.
  Future<Json> veiculos(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('veiculos', body, options);

  /// Consulta FIPE: `POST /consulta/fipe/credits`.
  Future<Json> fipe(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('fipe', body, options);

  /// Consulta GeoIP: `POST /consulta/geoip/credits`.
  Future<Json> geoip(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('geoip', body, options);

  /// Consulta Telefone: `POST /consulta/telefone/credits`.
  Future<Json> telefone(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('telefone', body, options);

  /// Consulta DDD: `POST /consulta/ddd-anatel/credits`.
  Future<Json> ddd(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('ddd-anatel', body, options);

  /// Consulta Rastreio: `POST /consulta/rastreio/credits`.
  Future<Json> rastreio(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('rastreio', body, options);

  /// Consulta CRM: `POST /consulta/crm/credits`.
  Future<Json> crm(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('crm', body, options);

  /// Consulta CRBM: `POST /consulta/crbm/credits`.
  Future<Json> crbm(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('crbm', body, options);

  /// Consulta CRO: `POST /consulta/cro/credits`.
  Future<Json> cro(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('cro', body, options);

  /// Consulta Weather: `POST /consulta/weather-api/credits`.
  Future<Json> weather(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('weather-api', body, options);

  /// Consulta Emissão de Notas: `POST /consulta/emissao-notas/credits`.
  Future<Json> emissaoNotas(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('emissao-notas', body, options);

  /// Consulta Frete ANTT: `POST /consulta/frete-antt/credits`.
  Future<Json> freteAntt(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('frete-antt', body, options);

  /// Consulta API RNTRC: `POST /consulta/api-rntrc/credits`.
  Future<Json> apiRntrc(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('api-rntrc', body, options);

  /// Consulta Quod: `POST /consulta/quod/credits` (ou CNPJ).
  Future<Json> quod(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('quod', body, options);

  /// Consulta qualquer serviço genérico.
  Future<Json> consulta(
    String service,
    Json body, [
    RequestOptions options = const RequestOptions(),
  ]) =>
      request(service, body, options);

  /// Verifica créditos disponíveis para um serviço: `GET /consulta/{service}/credits`.
  Future<Json> credits(
    String service, [
    RequestOptions options = const RequestOptions(),
  ]) =>
      http.get('consulta/$service/credits', options);
}