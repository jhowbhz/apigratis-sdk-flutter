import '../base_service.dart';
import '../core/types.dart';

/// Saldo, faturas, notificações, tickets (`/account/{action}` e `/balance`, `/invoices`, etc).
class AccountService extends BaseService {
  AccountService(super.http);

  /// Saldo da conta: `GET /balance`.
  Future<Json> balance([RequestOptions options = const RequestOptions()]) =>
      http.get('balance', options);

  /// Faturas: `GET /invoices`.
  Future<Json> invoices([RequestOptions options = const RequestOptions()]) =>
      http.get('invoices', options);

  /// Notificações: `GET /notifications`.
  Future<Json> notifications([RequestOptions options = const RequestOptions()]) =>
      http.get('notifications', options);

  /// Tickets: `GET /tickets`.
  Future<Json> tickets([RequestOptions options = const RequestOptions()]) =>
      http.get('tickets', options);

  /// Ticket específico: `GET /tickets/{id}`.
  Future<Json> ticket(String id, [RequestOptions options = const RequestOptions()]) =>
      http.get('tickets/$id', options);

  /// Cria ticket: `POST /tickets`.
  Future<Json> createTicket(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('tickets', body, options);

  /// Responde ticket: `POST /tickets/{id}/messages`.
  Future<Json> replyTicket(String id, Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('tickets/$id/messages', body, options);

  /// Perfil da conta: `GET /account/profile`.
  Future<Json> profile([RequestOptions options = const RequestOptions()]) =>
      http.get('account/profile', options);

  /// Atualiza perfil: `PUT /account/profile`.
  Future<Json> updateProfile(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.put('account/profile', body, options);

  /// Planos: `GET /plan`.
  Future<Json> plan([RequestOptions options = const RequestOptions()]) =>
      http.get('plan', options);

  /// Recargas: `GET /recharges`.
  Future<Json> recharges([RequestOptions options = const RequestOptions()]) =>
      http.get('recharges', options);
}