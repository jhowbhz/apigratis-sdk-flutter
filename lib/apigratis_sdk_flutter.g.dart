// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apigratis_sdk_flutter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      deviceToken: json['deviceToken'] as String,
      bearerToken: json['bearerToken'] as String,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'bearerToken': instance.bearerToken,
    };

Body _$BodyFromJson(Map<String, dynamic> json) => Body(
      text: json['text'] as String,
      number: json['number'] as String,
      timeTyping: (json['timeTyping'] as num).toInt(),
    );

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'text': instance.text,
      'number': instance.number,
      'timeTyping': instance.timeTyping,
    };

ApiRequest _$ApiRequestFromJson(Map<String, dynamic> json) => ApiRequest(
      credentials:
          Credentials.fromJson(json['credentials'] as Map<String, dynamic>),
      body: Body.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiRequestToJson(ApiRequest instance) =>
    <String, dynamic>{
      'credentials': instance.credentials,
      'body': instance.body,
    };
