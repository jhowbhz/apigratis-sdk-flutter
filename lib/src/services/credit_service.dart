import 'base_service.dart';
import '../core/types.dart';

/// Service for credit-based consultations (`/consulta/{service}/credits`).
/// These endpoints debit credits from the account and don't require DeviceToken.
class CreditService extends BaseService {
  CreditService(super.http);

  /// Executes a credit-based consultation.
  ///
  /// [service] - The consultation service (e.g., 'cpf', 'cnpj', 'cep', 'vehicles').
  /// [body] - Request body with fields specific to the consultation type.
  /// [options] - Optional request options.
  Future<Json> request(
    String service,
    Json body, [
    RequestOptions options = const RequestOptions(),
  ]) {
    final path = 'consulta/$service/credits';
    return post(path, body, options);
  }

  /// Checks available credits for a service.
  Future<Json> credits(
    String service, [
    RequestOptions options = const RequestOptions(),
  ]) {
    final path = 'consulta/$service/credits';
    return get(path, options);
  }
}
