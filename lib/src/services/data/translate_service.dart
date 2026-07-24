import '../device_proxy_service.dart';
import '../../core/http_client.dart';
import '../../core/types.dart';

/// Tradução (`/translate/{action}`).
/// Device-based (requires DeviceToken).
class TranslateService extends DeviceProxyService {
  TranslateService(ApiHttpClient http) : super(http, 'translate');

  /// Identifica idioma: `POST /translate/identify`.
  Future<Json> identify(Json body, [RequestOptions options = const RequestOptions()]) =>
      request('identify', body, options);

  /// Lista modelos: `POST /translate/models`.
  Future<Json> models([Json? body, RequestOptions options = const RequestOptions()]) =>
      request('models', body, options);
}
