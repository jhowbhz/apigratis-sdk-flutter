import '../base_service.dart';
import '../../core/types.dart';

/// URA reversa / ligações (`/ura/call/*`).
class UraService extends BaseService {
  UraService(super.http);

  /// Disca: `POST /ura/call/dialler`.
  Future<Json> dialler(Json body, [RequestOptions options = const RequestOptions()]) =>
      http.post('ura/call/dialler', body, options);

  /// Status da ligação: `POST /ura/call/status?callId=...`.
  Future<Json> status(String callId, [RequestOptions options = const RequestOptions()]) =>
      http.post('ura/call/status?callId=$callId', null, options);
}
