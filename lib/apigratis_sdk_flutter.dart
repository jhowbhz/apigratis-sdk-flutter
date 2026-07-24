/// {@template apigratis_sdk_flutter}
/// # APIBrasil SDK for Dart/Flutter
///
/// Official SDK for [APIBrasil](https://apibrasil.io) platform — WhatsApp, SMS,
/// CPF/CNPJ queries, vehicle data, CEP, Correios, PIX/boleto payments and more.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';
///
/// void main() async {
///   // Initialize with credentials
///   final api = ApiBrasil(
///     bearerToken: 'seu_bearer_token',
///     deviceToken: 'seu_device_token',
///   );
///
///   // WhatsApp - send text message
///   final result = await api.whatsapp.sendText({
///     'number': '5511999999999',
///     'text': 'Olá!'
///   });
///
///   // Consulta CPF
///   final cpf = await api.consulta.cpfDados({'cpf': '00000000000'});
///
///   // Get WhatsApp QR code
///   final qr = await api.whatsapp.qrcode();
/// }
/// ```
///
/// ## Services Overview
///
/// ### Messaging
/// - [WhatsAppService] - Device-based WhatsApp API (100+ actions)
/// - [EvolutionService] - Evolution API wrapper
/// - [WhatsMeowService] - WhatsMeow API wrapper
/// - [SmsService] - SMS device-based and credit-based
///
/// ### Data & Consultas
/// - [DadosService] - CPF, CNPJ, CNAE, sócios (device-based)
/// - [VehiclesService] - Vehicle data by plate + FIPE
/// - [FipeService] - Complete FIPE table
/// - [CorreiosService] - Package tracking
/// - [CepService] - CEP + geolocation
/// - [ConsultaService] - 210+ credit-based consultations
///
/// ### Platform
/// - [AuthService] - Login, 2FA, register, profile
/// - [DevicesService] - Device CRUD
/// - [AccountService] - Balance, invoices, tickets
/// - [PaymentsService] - PIX, boleto, card
/// - [CatalogService] - APIs, plans, docs, servers
/// - [ReportsService] - Dashboard, consumption, errors
/// - [IpWhitelistService], [BearerRateLimitService]
///
/// ## Migração da 0.0.x
///
/// As classes legadas foram renomeadas com o prefixo `Legacy` para liberar os
/// nomes aos serviços novos: `WhatsAppService` → [LegacyWhatsAppService],
/// `CpfService` → [LegacyCpfService], `SmsService` → [LegacySmsService].
/// Todas estão `@Deprecated` — prefira `ApiBrasil()`.
///
/// ## Configuration
///
/// Credentials can be passed directly or via environment variables:
/// - `APIBRASIL_BEARER_TOKEN`
/// - `APIBRASIL_DEVICE_TOKEN`
/// - `APIBRASIL_SECRET_KEY`
/// - `APIBRASIL_BASE_URL`
///
/// Or via `--dart-define` at compile time.
/// {@endtemplate}
library apigratis_sdk_flutter;

import 'package:json_annotation/json_annotation.dart';

import 'src/api_brasil.dart';
import 'src/core/http_client.dart';

// Re-export core types
export 'src/core/http_client.dart';
export 'src/core/types.dart';
export 'src/core/errors.dart';
export 'src/core/env.dart';
export 'src/core/transport.dart';
export 'src/core/retry.dart';

// Re-export generated catalog
export 'src/generated/catalog.dart';

// Re-export services
export 'src/api_brasil.dart';
export 'src/services/base_service.dart';
export 'src/services/device_proxy_service.dart';
export 'src/services/credit_service.dart';
export 'src/services/messaging.dart';
export 'src/services/data.dart';
export 'src/services/platform.dart';

// Re-export individual services for direct import
export 'src/services/messaging/whatsapp_service.dart';
export 'src/services/messaging/evolution_service.dart';
export 'src/services/messaging/whatsmeow_service.dart';
export 'src/services/messaging/sms_service.dart';
export 'src/services/data/dados_service.dart';
export 'src/services/data/vehicles_service.dart';
export 'src/services/data/fipe_service.dart';
export 'src/services/data/correios_service.dart';
export 'src/services/data/cep_service.dart';
export 'src/services/data/consulta_service.dart';
export 'src/services/data/chip_virtual_service.dart';
export 'src/services/data/ura_service.dart';
export 'src/services/data/bulk_service.dart';
export 'src/services/data/database_ip_service.dart';
export 'src/services/data/geolocation_service.dart';
export 'src/services/data/geomatrix_service.dart';
export 'src/services/data/recognize_service.dart';
export 'src/services/data/ddd_service.dart';
export 'src/services/data/holidays_service.dart';
export 'src/services/data/translate_service.dart';
export 'src/services/data/weather_service.dart';
export 'src/services/data/loterias_service.dart';
export 'src/services/platform/auth_service.dart';
export 'src/services/platform/devices_service.dart';
export 'src/services/platform/account_service.dart';
export 'src/services/platform/payments_service.dart';
export 'src/services/platform/ip_whitelist_service.dart';
export 'src/services/platform/bearer_rate_limit_service.dart';
export 'src/services/platform/reports_service.dart';
export 'src/services/platform/catalog_service.dart';

part 'apigratis_sdk_flutter.g.dart';

// Modelos de dados (mantidos para compatibilidade)
/// Credentials for device-based authentication.
@JsonSerializable()
class Credentials {
  /// Device token from APIBrasil.
  final String deviceToken;

  /// Bearer token (JWT) from authentication.
  final String bearerToken;

  /// Creates credentials.
  Credentials({required this.deviceToken, required this.bearerToken});

  factory Credentials.fromJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}

/// Request body for WhatsApp/SMS messages.
@JsonSerializable()
class Body {
  /// Message text.
  final String text;

  /// Destination phone number (with country code).
  final String number;

  /// Typing time in milliseconds.
  final int timeTyping;

  Body({required this.text, required this.number, required this.timeTyping});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
  Map<String, dynamic> toJson() => _$BodyToJson(this);
}

/// Full API request envelope with credentials and body.
@JsonSerializable()
class ApiRequest {
  /// Authentication credentials.
  final Credentials credentials;

  /// Request payload.
  final Body body;

  ApiRequest({required this.credentials, required this.body});

  factory ApiRequest.fromJson(Map<String, dynamic> json) => _$ApiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ApiRequestToJson(this);
}

/// Serviço legado, mantido apenas para migração da 0.0.x.
///
/// Usa [ApiBrasil] internamente — prefira [ApiBrasil] diretamente.
@Deprecated('Use ApiBrasil directly')
class ApiService {
  final String baseUrl = 'https://gateway.apibrasil.io/api/v2/';
  final ApiBrasil _api;

  ApiService({String? bearerToken, String? deviceToken})
      : _api = ApiBrasil(bearerToken: bearerToken, deviceToken: deviceToken);

  Future<Map<String, dynamic>> _sendRequest(String endpoint, ApiRequest request) async {
    final data = await _api.request('POST', endpoint, body: request.toJson());
    return asJsonMap(data);
  }
}

/// WhatsApp legado da 0.0.x. Use [ApiBrasil.whatsapp] (tipo `WhatsAppService`).
@Deprecated('Use ApiBrasil.whatsapp')
class LegacyWhatsAppService extends ApiService {
  LegacyWhatsAppService({super.bearerToken, super.deviceToken});

  Future<Map<String, dynamic>> sendText(ApiRequest request) {
    return _sendRequest('whatsapp/sendText', request);
  }

  Future<Map<String, dynamic>> sendFile(ApiRequest request) {
    return _sendRequest('whatsapp/sendFile', request);
  }

  Future<Map<String, dynamic>> sendImage(ApiRequest request) {
    return _sendRequest('whatsapp/sendImage', request);
  }
}

/// CPF legado da 0.0.x. Use `ApiBrasil.consulta.cpf` / `ApiBrasil.dados.cpf`.
@Deprecated('Use ApiBrasil.consulta')
class LegacyCpfService extends ApiService {
  LegacyCpfService({super.bearerToken, super.deviceToken});

  Future<Map<String, dynamic>> dados(ApiRequest request) {
    return _sendRequest('cpf/dados', request);
  }
}

/// SMS legado da 0.0.x. Use [ApiBrasil.sms] (tipo `SmsService`).
@Deprecated('Use ApiBrasil.sms')
class LegacySmsService extends ApiService {
  LegacySmsService({super.bearerToken, super.deviceToken});

  Future<Map<String, dynamic>> send(ApiRequest request) {
    return _sendRequest('sms/send', request);
  }
}
