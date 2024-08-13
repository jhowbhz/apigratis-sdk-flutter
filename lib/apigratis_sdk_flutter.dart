import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'apigratis_sdk_flutter.g.dart';

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
  final String message;
  final String phone;
  final int timeTyping;

  Body({required this.message, required this.phone, required this.timeTyping});

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

class ApiGratisSdk {
  final String baseUrl = 'https://gateway.apibrasil.io/api/v2/';

  Future<Map<String, dynamic>> sendText(ApiRequest request) async {
    final url = Uri.parse('$baseUrl/whatsapp');
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
      throw Exception('Failed to send request');
    }
  }
}
