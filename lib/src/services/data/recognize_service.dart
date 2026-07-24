import '../base_service.dart';
import '../core/types.dart';

/// OCR / Google Vision (`/recognize/{action}`).
/// Device-based (requires DeviceToken).
class RecognizeService extends BaseService {
  RecognizeService(super.http);

  /// Reconhece por base64: `POST /recognize/base64`.
  Future<Json> base64(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('recognize/base64', body, options);

  /// Reconhece por URI: `POST /recognize/uri`.
  Future<Json> uri(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('recognize/uri', body, options);
}