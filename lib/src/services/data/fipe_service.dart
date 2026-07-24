import '../base_service.dart';
import '../core/types.dart';

/// Tabela FIPE (`/fipe/{action}`).
class FipeService extends BaseService {
  FipeService(super.http);

  /// Consultar marcas: `POST /fipe/ConsultarMarcas`.
  Future<Json> consultarMarcas(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('fipe/ConsultarMarcas', body, options);

  /// Consultar modelos: `POST /fipe/ConsultarModelos`.
  Future<Json> consultarModelos(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('fipe/ConsultarModelos', body, options);

  /// Consultar modelos através do ano: `POST /fipe/ConsultarModelosAtravesDoAno`.
  Future<Json> consultarModelosAtravesDoAno(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('fipe/ConsultarModelosAtravesDoAno', body, options);

  /// Consultar tabela de referência: `POST /fipe/ConsultarTabelaDeReferencia`.
  Future<Json> consultarTabelaDeReferencia(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('fipe/ConsultarTabelaDeReferencia', body, options);

  /// Consultar ano modelo: `POST /fipe/ConsultarAnoModelo`.
  Future<Json> consultarAnoModelo(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('fipe/ConsultarAnoModelo', body, options);

  /// Consultar valor com todos parâmetros: `POST /fipe/ConsultarValorComTodosParametros`.
  Future<Json> consultarValorComTodosParametros(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('fipe/ConsultarValorComTodosParametros', body, options);
}