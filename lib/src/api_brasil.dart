import 'core/http_client.dart';
import 'core/transport.dart';
import 'core/types.dart';
import 'services.dart';

/// Cliente oficial da plataforma APIBrasil para Dart/Flutter.
///
/// ```dart
/// import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';
///
/// void main() async {
///   final api = ApiBrasil(
///     bearerToken: 'seu_bearer_token',
///     deviceToken: 'seu_device_token',
///   );
///
///   // WhatsApp
///   final result = await api.whatsapp.sendText({'number': '5511999999999', 'text': 'Olá!'});
///
///   // Consulta CPF
///   final cpf = await api.consulta.cpfDados({'cpf': '00000000000'});
///
///   // Device-based services (WhatsApp, SMS, etc)
///   final qr = await api.whatsapp.qrcode();
/// }
/// ```
class ApiBrasil {
  /// Cliente HTTP interno (headers, base URL, retry, hooks, erros).
  final ApiHttpClient http;

  /// Login, 2FA, cadastro, senha e perfil.
  final AuthService auth;

  /// Gestão de devices (criar, listar, atualizar, remover).
  final DevicesService devices;

  /// WhatsApp device-based (`/whatsapp/{action}`).
  final WhatsAppService whatsapp;

  /// Evolution API (`/evolution/{controller}/{action}`).
  final EvolutionService evolution;

  /// WhatsMeow (`/whatsmeow/{action}`).
  final WhatsMeowService whatsmeow;

  /// SMS (`/sms/{action}` e `/sms/send/credits`).
  final SmsService sms;

  /// Dados cadastrais device-based (`/dados/cpf`, `/dados/cnpj`...).
  final DadosService dados;

  /// Veículos por placa (`/vehicles/dados`, `/vehicles/fipe`).
  final VehiclesService vehicles;

  /// Tabela FIPE (`/fipe/{action}`).
  final FipeService fipe;

  /// Correios (`/correios/{action}`).
  final CorreiosService correios;

  /// CEP + geolocalização (`/cep/{action}`).
  final CepService cep;

  /// Geolocalização (`/geolocation/{action}`).
  final GeolocationService geolocation;

  /// Matriz de distâncias (`/geomatrix/{action}`).
  final GeomatrixService geomatrix;

  /// OCR / Google Vision (`/recognize/{action}`).
  final RecognizeService recognize;

  /// DDD (`/ddd/{action}`).
  final DddService ddd;

  /// Feriados (`/holidays/{action}`).
  final HolidaysService holidays;

  /// Tradução (`/translate/{action}`).
  final TranslateService translate;

  /// Clima (`/weather/{action}`).
  final WeatherService weather;

  /// Loterias (`/loterias/{action}`).
  final LoteriasService loterias;

  /// GeoIP (`/database/ip`).
  final DatabaseIpService databaseIp;

  /// Consultas por crédito (`/consulta/{servico}/credits`).
  final ConsultaService consulta;

  /// URA reversa / ligações (`/ura/call/*`).
  final UraService ura;

  /// Chip virtual (`/chip/virtual/*`).
  final ChipVirtualService chipVirtual;

  /// Execução em lote (`/bulk/*`).
  final BulkService bulk;

  /// Catálogo de APIs, planos, docs e servidores.
  final CatalogService catalog;

  /// Saldo, faturas, notificações, tickets.
  final AccountService account;

  /// Recargas e pagamentos (PIX, boleto, cartão).
  final PaymentsService payments;

  /// IP whitelist da conta.
  final IpWhitelistService ipWhitelist;

  /// Rate limit por Bearer Token.
  final BearerRateLimitService bearerRateLimit;

  /// Relatórios e dashboard de consumo.
  final ReportsService reports;

  /// Cria um novo cliente APIBrasil.
  ///
  /// [config] - Configurações opcionais. Campos não informados são lidos das
  /// variáveis de ambiente `APIBRASIL_BEARER_TOKEN`, `APIBRASIL_DEVICE_TOKEN`,
  /// `APIBRASIL_SECRET_KEY` e `APIBRASIL_BASE_URL`.
  ///
  /// ```dart
  /// final api = ApiBrasil(
  ///   bearerToken: 'token',
  ///   deviceToken: 'device_token',
  ///   baseUrl: 'https://gateway.apibrasil.io/api/v2',
  ///   timeout: Duration(seconds: 30),
  /// );
  /// ```
  ApiBrasil({
    String? bearerToken,
    String? deviceToken,
    String? secretKey,
    String? baseUrl,
    Duration? timeout,
    Map<String, String>? headers,
    Transport? transport,
    RetryConfig? retry,
    ApiBrasilHooks? hooks,
  }) : this.withClient(ApiHttpClient(ApiBrasilConfig(
          bearerToken: bearerToken,
          deviceToken: deviceToken,
          secretKey: secretKey,
          baseUrl: baseUrl,
          timeout: timeout,
          headers: headers,
          transport: transport,
          retry: retry,
          hooks: hooks,
        )));

  /// Cria o cliente sobre um [ApiHttpClient] já configurado.
  ///
  /// Todos os serviços compartilham esse mesmo cliente — logo, um
  /// [setBearerToken] vale para todos, e [close] libera um único transporte.
  ApiBrasil.withClient(ApiHttpClient client)
      : http = client,
        auth = AuthService(client),
        devices = DevicesService(client),
        whatsapp = WhatsAppService(client),
        evolution = EvolutionService(client),
        whatsmeow = WhatsMeowService(client),
        sms = SmsService(client),
        dados = DadosService(client),
        vehicles = VehiclesService(client),
        fipe = FipeService(client),
        correios = CorreiosService(client),
        cep = CepService(client),
        geolocation = GeolocationService(client),
        geomatrix = GeomatrixService(client),
        recognize = RecognizeService(client),
        ddd = DddService(client),
        holidays = HolidaysService(client),
        translate = TranslateService(client),
        weather = WeatherService(client),
        loterias = LoteriasService(client),
        databaseIp = DatabaseIpService(client),
        consulta = ConsultaService(client),
        ura = UraService(client),
        chipVirtual = ChipVirtualService(client),
        bulk = BulkService(client),
        catalog = CatalogService(client),
        account = AccountService(client),
        payments = PaymentsService(client),
        ipWhitelist = IpWhitelistService(client),
        bearerRateLimit = BearerRateLimitService(client),
        reports = ReportsService(client);

  /// Faz login e retorna um cliente já autenticado.
  /// Lança exceção se a conta exigir 2FA — nesse caso crie o cliente
  /// manualmente e use `auth.login()` + `auth.verify2fa()`.
  ///
  /// ```dart
  /// final result = await ApiBrasil.login({'email': '...', 'password': '...'});
  /// final api = result.client;
  /// final session = result.session;
  /// ```
  static Future<({ApiBrasil client, dynamic session})> login(
    Map<String, dynamic> credentials, {
    String? bearerToken,
    String? deviceToken,
    String? secretKey,
    String? baseUrl,
    Duration? timeout,
    Map<String, String>? headers,
    Transport? transport,
    RetryConfig? retry,
    ApiBrasilHooks? hooks,
  }) async {
    final client = ApiBrasil(
      bearerToken: bearerToken,
      deviceToken: deviceToken,
      secretKey: secretKey,
      baseUrl: baseUrl,
      timeout: timeout,
      headers: headers,
      transport: transport,
      retry: retry,
      hooks: hooks,
    );
    final session = await client.auth.login(credentials);

    if (session['requires_2fa'] == true) {
      throw Exception(
          'Esta conta exige autenticação em dois fatores. Use auth.login() + auth.verify2fa().');
    }

    return (client: client, session: session);
  }

  /// Define/atualiza o Bearer Token do cliente.
  void setBearerToken(String token) => http.setBearerToken(token);

  /// Define/atualiza o DeviceToken do cliente.
  void setDeviceToken(String token) => http.setDeviceToken(token);

  /// Retorna um novo cliente com as mesmas credenciais, mas apontando
  /// para outro device — útil para gerenciar vários números/instâncias.
  ApiBrasil withDevice(String deviceToken) {
    final config = http.config;
    return ApiBrasil(
      bearerToken: config.bearerToken,
      deviceToken: deviceToken,
      secretKey: config.secretKey,
      baseUrl: config.baseUrl,
      timeout: config.timeout,
      headers: config.headers,
      transport: config.transport,
      retry: config.retry,
      hooks: config.hooks,
    );
  }

  /// Porta de saída genérica: chama qualquer endpoint do gateway com os
  /// headers de autenticação já configurados. Use para rotas que ainda
  /// não têm método dedicado na SDK.
  ///
  /// ```dart
  /// await api.request('POST', '/consulta/cpf/credits', {'cpf': '...'});
  /// ```
  Future<dynamic> request(
    String method,
    String path, {
    Object? body,
    RequestOptions options = const RequestOptions(),
  }) =>
      http.request(HttpMethod.values.byName(method.toLowerCase()), path,
          body: body, options: options);

  /// Fecha o transporte e libera as conexões.
  void close() => http.close();
}
