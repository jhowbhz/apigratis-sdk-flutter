import '../base_service.dart';
import '../core/types.dart';

/// Login, 2FA, cadastro, senha e perfil (`/auth/{action}`).
/// Requer apenas `Authorization: Bearer` (após login).
class AuthService extends BaseService {
  AuthService(super.http);

  /// Login: `POST /auth/login`.
  /// Retorna session com token, expiração, requires_2fa, etc.
  Future<Json> login(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('auth/login', body, options);

  /// Verifica 2FA: `POST /auth/verify2fa`.
  Future<Json> verify2fa(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('auth/verify2fa', body, options);

  /// Logout: `POST /auth/logout`.
  Future<Json> logout([Json? body, RequestOptions options = const RequestOptions()]) =>
      http.post('auth/logout', body, options);

  /// Cadastro: `POST /auth/register`.
  Future<Json> register(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('auth/register', body, options);

  /// Esqueci senha: `POST /auth/forgot-password`.
  Future<Json> forgotPassword(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('auth/forgot-password', body, options);

  /// Redefinir senha: `POST /auth/reset-password`.
  Future<Json> resetPassword(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('auth/reset-password', body, options);

  /// Perfil do usuário: `GET /auth/profile`.
  Future<Json> profile([RequestOptions options = const RequestOptions()]) =>
      http.get('auth/profile', options);

  /// Atualiza perfil: `PUT /auth/profile`.
  Future<Json> updateProfile(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.put('auth/profile', body, options);

  /// Altera senha: `PUT /auth/password`.
  Future<Json> changePassword(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.put('auth/password', body, options);

  /// Habilita 2FA: `POST /auth/2fa/enable`.
  Future<Json> enable2fa([Json? body, RequestOptions options = const RequestOptions()]) =>
      http.post('auth/2fa/enable', body, options);

  /// Desabilita 2FA: `POST /auth/2fa/disable`.
  Future<Json> disable2fa([Json? body, RequestOptions options = const RequestOptions()]) =>
      http.post('auth/2fa/disable', body, options);
}