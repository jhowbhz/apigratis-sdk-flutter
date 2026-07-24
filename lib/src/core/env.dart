import 'types.dart';

import 'env_stub.dart' if (dart.library.io) 'env_io.dart';

/// Variáveis de ambiente reconhecidas pela SDK.
abstract final class EnvVars {
  static const String bearerToken = 'APIBRASIL_BEARER_TOKEN';
  static const String deviceToken = 'APIBRASIL_DEVICE_TOKEN';
  static const String secretKey = 'APIBRASIL_SECRET_KEY';
  static const String baseUrl = 'APIBRASIL_BASE_URL';

  static const List<String> all = [bearerToken, deviceToken, secretKey, baseUrl];
}

// Valores de `--dart-define`, resolvidos em tempo de compilação. É o único
// caminho disponível no Flutter web, onde não existe ambiente de processo.
const String _definedBearerToken = String.fromEnvironment(EnvVars.bearerToken);
const String _definedDeviceToken = String.fromEnvironment(EnvVars.deviceToken);
const String _definedSecretKey = String.fromEnvironment(EnvVars.secretKey);
const String _definedBaseUrl = String.fromEnvironment(EnvVars.baseUrl);

String? _read(String name, String defined) {
  final value = platformEnvironment[name];
  if (value != null && value.isNotEmpty) return value;
  return defined.isNotEmpty ? defined : null;
}

/// Lê a configuração das variáveis de ambiente (quando disponíveis) e dos
/// `--dart-define` de mesmo nome. Valores passados explicitamente no
/// construtor sempre têm prioridade.
///
/// ```bash
/// flutter run --dart-define=APIBRASIL_BEARER_TOKEN=...
/// ```
ApiBrasilConfig configFromEnv() {
  return ApiBrasilConfig(
    bearerToken: _read(EnvVars.bearerToken, _definedBearerToken),
    deviceToken: _read(EnvVars.deviceToken, _definedDeviceToken),
    secretKey: _read(EnvVars.secretKey, _definedSecretKey),
    baseUrl: _read(EnvVars.baseUrl, _definedBaseUrl),
  );
}
