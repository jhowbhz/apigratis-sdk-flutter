import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'apigratis_sdk_flutter.g.dart';

// Definições dos modelos
@JsonSerializable()
class Credentials {
  final String deviceToken;
  final String bearerToken;

  Credentials({required this.deviceToken, required this.bearerToken});

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}

@JsonSerializable()
class Body {
  final String text;
  final String number;
  final int timeTyping;

  Body({required this.text, required this.number, required this.timeTyping});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
  Map<String, dynamic> toJson() => _$BodyToJson(this);
}

@JsonSerializable()
class ApiRequest {
  final Credentials credentials;
  final Body body;

  ApiRequest({required this.credentials, required this.body});

  factory ApiRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ApiRequestToJson(this);
}

// Classe base para chamadas HTTP
class ApiService {
  final String baseUrl = 'https://gateway.apibrasil.io/api/v2/';

  Future<Map<String, dynamic>> _sendRequest(String endpoint, ApiRequest request) async {
    final url = Uri.parse('$baseUrl$endpoint');
    print('Request URL: $url'); // Debug: Mostre a URL

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${request.credentials.bearerToken}',
      'DeviceToken': request.credentials.deviceToken,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send request. Status Code: ${response.statusCode}, Response Body: ${response.body}');
    }
  }
}

// Serviço de WhatsApp
class WhatsAppService extends ApiService {
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

// Serviço de CPF
class CpfService extends ApiService {
  Future<Map<String, dynamic>> dados(ApiRequest request) {
    return _sendRequest('cpf/dados', request);
  }
}

// Serviço de SMS
class SmsService extends ApiService {
  Future<Map<String, dynamic>> send(ApiRequest request) {
    return _sendRequest('sms/send', request);
  }
}