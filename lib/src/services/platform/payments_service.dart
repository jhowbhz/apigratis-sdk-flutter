import '../base_service.dart';
import '../../core/types.dart';

/// Recargas e pagamentos (PIX, boleto, cartão) (`/recharge`, `/payments`, `/invoices/{id}/pay`).
class PaymentsService extends BaseService {
  PaymentsService(super.http);

  /// Recarga via PIX: `POST /recharge/pix`.
  Future<Json> rechargePix(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('recharge/pix', body, options);

  /// Recarga via boleto: `POST /recharge/boleto`.
  Future<Json> rechargeBoleto(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('recharge/boleto', body, options);

  /// Recarga via cartão: `POST /recharge/card`.
  Future<Json> rechargeCard(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('recharge/card', body, options);

  /// Pagamento de fatura via PIX: `POST /invoices/{id}/pay/pix`.
  Future<Json> payInvoicePix(String id, Json body,
          [RequestOptions options = const RequestOptions()]) =>
      http.post('invoices/$id/pay/pix', body, options);

  /// Pagamento de fatura via boleto: `POST /invoices/{id}/pay/boleto`.
  Future<Json> payInvoiceBoleto(String id, Json body,
          [RequestOptions options = const RequestOptions()]) =>
      http.post('invoices/$id/pay/boleto', body, options);

  /// Pagamento de fatura via cartão: `POST /invoices/{id}/pay/card`.
  Future<Json> payInvoiceCard(String id, Json body,
          [RequestOptions options = const RequestOptions()]) =>
      http.post('invoices/$id/pay/card', body, options);

  /// Histórico de pagamentos: `GET /payments`.
  Future<Json> payments([RequestOptions options = const RequestOptions()]) =>
      http.get('payments', options);

  /// Métodos de pagamento: `GET /payments/methods`.
  Future<Json> paymentMethods([RequestOptions options = const RequestOptions()]) =>
      http.get('payments/methods', options);
}
