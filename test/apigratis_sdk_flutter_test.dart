import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';
import 'package:test/test.dart';

void main() {
  test('sendText should return a response', () async {
    final sdk = ApiGratisSdk();

    final request = ApiRequest(
      credentials: Credentials(
        deviceToken: 'f937d7f6-7b36-4872-b666-421078131733',
        bearerToken: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...',
      ),
      body: Body(
        message: 'Hello World for Flutter',
        phone: '5531994359434',
        timeTyping: 1,
      ),
    );

    try {
      final response = await sdk.sendText(request);
      print('Response: $response');
    } catch (e) {
      print('Error: $e');
    }
  });
}
