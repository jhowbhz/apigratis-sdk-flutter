import 'dart:convert';

import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';
import 'package:test/test.dart';

/// Transporte de teste: registra as requisições e devolve respostas roteirizadas
/// sem tocar na rede.
class FakeTransport implements Transport {
  FakeTransport(this._responses);

  final List<TransportResponse> _responses;
  final List<TransportRequest> requests = [];
  var closed = false;

  @override
  Future<TransportResponse> send(TransportRequest request) async {
    requests.add(request);
    if (_responses.isEmpty) {
      return const TransportResponse(status: 200, data: {'ok': true});
    }
    return _responses.length == 1 ? _responses.first : _responses.removeAt(0);
  }

  @override
  void close() => closed = true;
}

TransportResponse jsonResponse(int status, Object body, {Map<String, String> headers = const {}}) =>
    TransportResponse(
      status: status,
      data: jsonDecode(jsonEncode(body)),
      headers: headers,
    );

ApiBrasil clientWith(FakeTransport transport, {RetryConfig? retry}) => ApiBrasil(
      bearerToken: 'bearer-test',
      deviceToken: 'device-test',
      transport: transport,
      retry: retry,
    );

void main() {
  group('ApiHttpClient', () {
    test('monta a URL a partir da base padrão e do path', () async {
      final transport = FakeTransport([
        jsonResponse(200, {'ok': true})
      ]);
      final api = clientWith(transport);

      await api.cep.cep({'cep': '01001000'});

      expect(transport.requests.single.url, 'https://gateway.apibrasil.io/api/v2/cep/cep');
      expect(transport.requests.single.method, HttpMethod.post);
    });

    test('envia os headers de autenticação da plataforma', () async {
      final transport = FakeTransport([
        jsonResponse(200, {'ok': true})
      ]);
      final api = clientWith(transport);

      await api.cep.cep({'cep': '01001000'});

      final headers = transport.requests.single.headers;
      expect(headers['Authorization'], 'Bearer bearer-test');
      expect(headers['DeviceToken'], 'device-test');
      expect(headers['Content-Type'], 'application/json');
      expect(headers['User-Agent'], sdkUserAgent);
    });

    test('serializa o corpo como JSON', () async {
      final transport = FakeTransport([
        jsonResponse(200, {'ok': true})
      ]);
      final api = clientWith(transport);

      await api.whatsapp.sendText({'number': '5511999999999', 'text': 'Olá'});

      expect(
        jsonDecode(transport.requests.single.body!),
        {'number': '5511999999999', 'text': 'Olá'},
      );
    });

    test('respostas que não são objetos JSON viram {data: ...}', () async {
      final transport = FakeTransport([
        jsonResponse(200, [1, 2, 3])
      ]);
      final api = clientWith(transport);

      expect(await api.cep.cep({'cep': '01001000'}), {
        'data': [1, 2, 3]
      });
    });

    test('baseUrl customizada é respeitada', () async {
      final transport = FakeTransport([
        jsonResponse(200, {'ok': true})
      ]);
      final api = ApiBrasil(
        bearerToken: 'b',
        baseUrl: 'https://exemplo.test/api/',
        transport: transport,
      );

      await api.cep.cep({'cep': '01001000'});

      expect(transport.requests.single.url, 'https://exemplo.test/api/cep/cep');
    });

    test('close() encerra o transporte', () {
      final transport = FakeTransport([]);
      clientWith(transport).close();
      expect(transport.closed, isTrue);
    });
  });

  group('Erros', () {
    Future<void> expectsError<T extends ApiBrasilError>(int status) async {
      final transport = FakeTransport([
        jsonResponse(status, {'message': 'falhou'})
      ]);
      final api = clientWith(transport, retry: const RetryConfig(retries: 0));

      await expectLater(
        api.cep.cep({'cep': '01001000'}),
        throwsA(isA<T>().having((e) => e.status, 'status', status)),
      );
    }

    test('401 -> AuthenticationError', () => expectsError<AuthenticationError>(401));
    test('403 -> PermissionError', () => expectsError<PermissionError>(403));
    test('404 -> NotFoundError', () => expectsError<NotFoundError>(404));
    test('422 -> ValidationError', () => expectsError<ValidationError>(422));
    test('429 -> RateLimitError', () => expectsError<RateLimitError>(429));
    test('500 -> ServerError', () => expectsError<ServerError>(500));

    test('todos os erros descendem de ApiBrasilError', () async {
      final transport = FakeTransport([
        jsonResponse(401, {'message': 'nope'})
      ]);
      final api = clientWith(transport);

      await expectLater(
        api.cep.cep({'cep': '01001000'}),
        throwsA(isA<ApiBrasilError>()),
      );
    });
  });

  group('Retry', () {
    test('repete em HTTP 429 e devolve a resposta bem-sucedida', () async {
      final transport = FakeTransport([
        jsonResponse(429, {'message': 'slow down'}),
        jsonResponse(200, {'ok': true}),
      ]);
      final api = clientWith(
        transport,
        retry: const RetryConfig(retries: 1, minDelay: Duration.zero),
      );

      expect(await api.cep.cep({'cep': '01001000'}), {'ok': true});
      expect(transport.requests.length, 2);
    });

    test('não repete em erro de negócio (422)', () async {
      final transport = FakeTransport([
        jsonResponse(422, {'message': 'cep inválido'}),
        jsonResponse(200, {'ok': true}),
      ]);
      final api = clientWith(
        transport,
        retry: const RetryConfig(retries: 3, minDelay: Duration.zero),
      );

      await expectLater(
        api.cep.cep({'cep': 'x'}),
        throwsA(isA<ValidationError>()),
      );
      expect(transport.requests.length, 1);
    });
  });

  group('Hooks', () {
    test('onRequest e onResponse são disparados', () async {
      final transport = FakeTransport([
        jsonResponse(200, {'ok': true})
      ]);
      final seen = <String>[];
      final api = ApiBrasil(
        bearerToken: 'b',
        deviceToken: 'd',
        transport: transport,
        hooks: ApiBrasilHooks(
          onRequest: (info) => seen.add('request:${info.method.value}'),
          onResponse: (info) => seen.add('response:${info.status}'),
        ),
      );

      await api.cep.cep({'cep': '01001000'});

      expect(seen, ['request:POST', 'response:200']);
    });
  });

  group('Tokens', () {
    test('setBearerToken e setDeviceToken atualizam os headers', () async {
      final transport = FakeTransport([
        jsonResponse(200, {'ok': true})
      ]);
      final api = clientWith(transport);

      api.setBearerToken('novo-bearer');
      api.setDeviceToken('novo-device');
      await api.cep.cep({'cep': '01001000'});

      final headers = transport.requests.single.headers;
      expect(headers['Authorization'], 'Bearer novo-bearer');
      expect(headers['DeviceToken'], 'novo-device');
    });
  });

  group('joinUrl', () {
    test('não duplica barras', () {
      expect(joinUrl('https://a.test/api/', '/cep/cep'), 'https://a.test/api/cep/cep');
      expect(joinUrl('https://a.test/api', 'cep/cep'), 'https://a.test/api/cep/cep');
    });
  });

  group('Catalog', () {
    test('expõe as actions conhecidas', () {
      expect(Catalog.whatsappActions, isNotEmpty);
      expect(Catalog.consultaTipos, isNotEmpty);
    });
  });
}
