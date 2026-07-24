import '../base_service.dart';
import '../../core/types.dart';

/// Chip Virtual (`/chip/virtual/{action}`).
class ChipVirtualService extends BaseService {
  ChipVirtualService(super.http);

  /// Compra chip: `POST /chip/virtual/buy`.
  Future<Json> buy(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('chip/virtual/buy', body, options);

  /// Ativação: `POST /chip/virtual/activation`.
  Future<Json> activation(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('chip/virtual/activation', body, options);

  /// Operadoras: `GET /chip/virtual/operators`.
  Future<Json> operators([RequestOptions options = const RequestOptions()]) =>
      http.get('chip/virtual/operators', options);

  /// Serviços: `GET /chip/virtual/services`.
  Future<Json> services([RequestOptions options = const RequestOptions()]) =>
      http.get('chip/virtual/services', options);
}
