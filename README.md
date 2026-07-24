# SDK Flutter/Dart - APIGratis by APIBrasil

SDK oficial Dart/Flutter da plataforma [APIBrasil](https://apibrasil.com.br) — WhatsApp, SMS, consultas de CPF/CNPJ, veículos, CEP, correios, pagamentos PIX/boleto e muito mais.

[![pub version](https://img.shields.io/pub/v/apigratis_sdk_flutter.svg)](https://pub.dev/packages/apigratis_sdk_flutter)
[![license MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub issues](https://img.shields.io/github/issues/APIBrasil/apigratis-sdk-flutter)](https://github.com/APIBrasil/apigratis-sdk-flutter/issues)
[![GitHub stars](https://img.shields.io/github/stars/APIBrasil/apigratis-sdk-flutter)](https://github.com/APIBrasil/apigratis-sdk-flutter/stargazers)

## Canais de suporte (Comunidade)

[![WhatsApp Group](https://img.shields.io/badge/WhatsApp-Group-25D366?logo=whatsapp)](https://chat.whatsapp.com/EeAWALQb6Ga5oeTbG7DD2k)
[![Telegram Group](https://img.shields.io/badge/Telegram-Group-32AFED?logo=telegram)](https://t.me/apigratisoficial)

## Instalação

```yaml
dependencies:
  apigratis_sdk_flutter: ^0.1.0
```

```bash
flutter pub get
```

Requer **Dart >= 3.5** (compatível com Flutter 3.19+ e Dart standalone).

Obtenha suas credenciais em https://apibrasil.com.br

## Começando

```dart
import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';

void main() async {
  // Initialize with credentials
  final api = ApiBrasil(
    bearerToken: 'seu_bearer_token',  // JWT do login
    deviceToken: 'seu_device_token',  // device dos serviçs device-based
  );

  // WhatsApp - enviar texto
  final result = await api.whatsapp.sendText({
    'number': '5511999999999',
    'text': 'Olá! 👋'
  });

  // Consulta CNPJ (por créditos)
  final empresa = await api.consulta.cnpj({'cnpj': '00000000000000'});
  print(empresa['data']);

  // QR Code WhatsApp
  final qr = await api.whatsapp.qrcode();
  print(qr['response']['qrcode']); // data URI base64
}
```

As credenciais também podem vir do ambiente — `ApiBrasil()` lê automaticamente
`APIBRASIL_BEARER_TOKEN`, `APIBRASIL_DEVICE_TOKEN`, `APIBRASIL_SECRET_KEY` e `APIBRASIL_BASE_URL`.

Também via `--dart-define` no build:

```bash
flutter run --dart-define=APIBRASIL_BEARER_TOKEN=... --dart-define=APIBRASIL_DEVICE_TOKEN=...
```

Todas as respostas são devolvidas como **Map<String, dynamic>** já decodificado.

### Login por email/senha

O token retornado fica guardado no cliente:

```dart
final result = await ApiBrasil.login({
  'email': 'voce@empresa.com.br',
  'password': '******'
});
final api = result.client;

// Contas com 2FA:
final session = await api.auth.login({'email': email, 'password': password});
if (session['requires_2fa'] == true) {
  await api.auth.verify2fa({'challenge': session['challenge'], 'code': '000000'});
}
```

## Como a plataforma funciona

A API Brasil tem duas famílias de serviços:

| Família          | Autenticação                                   | Exemplos                                                                    |
| ---------------- | ---------------------------------------------- | --------------------------------------------------------------------------- |
| **Device-based** | `Authorization: Bearer` + header `DeviceToken` | WhatsApp, SMS, veículos, CEP, correios, DDD, feriados, tradução, clima, OCR |
| **Por créditos** | apenas `Authorization: Bearer` (debita saldo)  | `consulta->cpf`, `consulta->cnpj`, `consulta->veiculos`, Serasa, CNH, telefone |

Para os serviços device-based, crie um device com a `SecretKey` da API desejada (painel APIBrasil) e use o `device_token` retornado:

```dart
final device = await api.devices.create(
  {'device_name': 'meu-bot', 'type': 'server'},
  const RequestOptions(secretKey: 'SUA_SECRET_KEY'),
);

api.setDeviceToken(device['device']['device_token']);
```

## Serviços disponíveis

| Módulo                                                            | Descrição                                                                                                    |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `api.whatsapp`                                                    | WhatsApp: `start`, `qrcode`, `sendText`, `sendFile`, `sendAudio`, `sendVideo`, fila (`queue`)...              |
| `api.evolution`                                                   | Evolution API: `request(controller, action, body)`                                                          |
| `api.whatsmeow`                                                   | WhatsMeow: `request(action, body)`                                                                           |
| `api.sms`                                                         | SMS device-based (`send`) e por créditos (`sendWithCredits`)                                                 |
| `api.dados`                                                       | Dados cadastrais device-based (`cpf`, `cnpj`)                                                                |
| `api.vehicles`                                                    | Veículos por placa (`dados`, `fipe`, `baseDados`)                                                            |
| `api.fipe`                                                        | Tabela FIPE (`consultarMarcas`, `consultarModelos`, `consultarAnoModelo`, `consultarTabelaDeReferencia`...) |
| `api.correios`                                                    | Correios (`rastreio`)                                                                                        |
| `api.cep`                                                         | CEP + geolocalização (`cep`, `bairros`, `cidades`, `cidadesPorDdd`, `estados`, `calcularDistancia`)          |
| `api.geolocation` / `api.geomatrix`                               | Geolocalização e matriz de distâncias                                                                        |
| `api.recognize`                                                   | OCR / Google Vision (`base64`, `uri`)                                                                        |
| `api.ddd` / `api.holidays` / `api.translate` / `api.weather`      | DDD, feriados, tradução, clima                                                                               |
| `api.databaseIp`                                                  | GeoIP (`ip`)                                                                                                 |
| `api.consulta`                                                    | Consultas por créditos: `cpf`, `cnpj`, `cnh`, `cep`, `veiculos`, `telefone`, `generic(service, body)`       |
| `api.ura` / `api.chipVirtual`                                     | URA reversa e chip virtual                                                                                   |
| `api.bulk`                                                        | Execução em lote (`create`, `status`, `list`)                                                                |
| `api.auth`                                                        | Login, 2FA, cadastro, recuperação de senha, perfil                                                           |
| `api.devices`                                                     | CRUD de devices                                                                                              |
| `api.catalog`                                                     | Catálogo de APIs, planos, documentações, servidores                                                          |
| `api.account`                                                     | Saldo, faturas, notificações, tickets                                                                        |
| `api.payments`                                                    | Recargas e pagamentos PIX/boleto/cartão (Santander, Inter, Mercado Pago, Sicoob)                            |
| `api.ipWhitelist` / `api.bearerRateLimit`                         | Segurança da conta                                                                                           |
| `api.reports`                                                     | Relatórios e dashboard de consumo                                                                            |

### WhatsApp

```dart
// Iniciar sessão e obter QR Code
await api.whatsapp.start({'webhook_wh_message': 'https://seu-webhook.com/mensagens'});

final qr = await api.whatsapp.qrcode();
print(qr['response']['qrcode']); // data URI base64

// Envios
await api.whatsapp.sendText({'number': '5511999999999', 'text': 'Olá!'});
await api.whatsapp.sendFile({'number': '5511999999999', 'path': 'https://exemplo.com/nota.pdf'});
await api.whatsapp.sendAudio({'number': '5511999999999', 'path': 'https://exemplo.com/audio.mp3'});

// Qualquer action da documentação, inclusive via fila
await api.whatsapp.request('sendLocation', {'number': '5511999999999', 'lat': -23.5, 'lng': -46.6});
await api.whatsapp.queue('sendText', {'number': '5511999999999', 'text': 'assíncrono 👋'});
```

### Consultas por créditos

```dart
// CPF / CNPJ
final cpf = await api.consulta.cpf({'cpf': '00000000000'});
final socios = await api.consulta.cnpj({'cnpj': '00000000000000', 'tipo': 'lista-socios'});

// Veicular
final veiculo = await api.consulta.veiculos({'placa': 'ABC1234'});

// Qualquer produto do catálogo
final score = await api.consulta.consulta('cpf', {'cpf': '00000000000', 'tipo': 'serasa-score-pf'});

// Homologação (sandbox, sem cobrança)
final teste = await api.consulta.cpf({'cpf': '00000000000', 'homolog': true});
```

### Veículos e FIPE (device-based)

```dart
final dados = await api.vehicles.dados({'placa': 'ABC1234'});
final fipe = await api.vehicles.fipe({'placa': 'ABC1234'});
```

### SMS

```dart
await api.sms.send({'number': '5511999999999', 'message': 'Seu código: 123456'});
// Ou debitando créditos da conta (sem device):
await api.sms.sendWithCredits({'number': '5511999999999', 'message': 'Olá!'});
```

### Pagamentos e recargas

```dart
// Recargas de saldo
final pix = await api.payments.rechargePix({'amount': 100});
final boleto = await api.payments.rechargeBoleto({'amount': 150});
final cartao = await api.payments.rechargeCard({'amount': 200});

// Pagamento de faturas
await api.payments.payInvoicePix('INVOICE_ID', {});

// Histórico e métodos disponíveis
final historico = await api.payments.payments();
final metodos = await api.payments.paymentMethods();
```

### Múltiplos devices

```dart
final comercial = api.withDevice('DEVICE_TOKEN_COMERCIAL');
final suporte = api.withDevice('DEVICE_TOKEN_SUPORTE');

await comercial.whatsapp.sendText({'number': '55...', 'text': 'Proposta enviada!'});
await suporte.whatsapp.sendText({'number': '55...', 'text': 'Como posso ajudar?'});
```

## Tratamento de erros

Cada categoria de falha tem a sua própria classe — todas estendem `ApiBrasilError`
(que por sua vez implementa `Exception`):

| Classe                          | Quando                                     |
| ------------------------------- | ------------------------------------------ |
| `ValidationError`               | 400/422 — payload inválido                 |
| `AuthenticationError`           | 401 — token ausente/expirado               |
| `InsufficientBalanceError`      | 402 — sem saldo/créditos                   |
| `PermissionError`               | 403 — sem permissão (ex: exige PJ)         |
| `NotFoundError`                 | 404/410 — sem dados / rota desativada      |
| `RateLimitError`                | 429 — limite atingido (`retryAfter`)       |
| `ServerError`                   | 5xx — erro do gateway/provedor             |
| `NetworkError` / `TimeoutError` | falha antes da resposta                    |

```dart
import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';

try {
  await api.consulta.cpf({'cpf': '00000000000'});
} on InsufficientBalanceError catch (e) {
  print('Recarregue seus créditos');
} on RateLimitError catch (e) {
  print('Aguarde ${e.retryAfter?.inMilliseconds}ms');
} on ApiBrasilError catch (e) {
  print('Erro: ${e.message} (HTTP ${e.status}, código ${e.code})');
}
```

Todo erro expõe `status` (HTTP), `code` (código da API) e `response` (corpo completo).

## Retry e observabilidade

Por padrão a SDK refaz a chamada em **HTTP 429** e em **falhas de conexão** (2 tentativas extras, backoff exponencial, respeitando `Retry-After`). Timeouts e erros de negócio nunca são refeitos — evita duplicar cobranças e envios.

```dart
final api = ApiBrasil(
  bearerToken: '...',
  deviceToken: '...',
  retry: RetryConfig(
    retries: 3,
    minDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 5),
    retryOnStatuses: [429, 503],
  ),
  hooks: ApiBrasilHooks(
    onRequest: (info) => print('→ ${info.method.value} ${info.url} (#${info.attempt})'),
    onResponse: (info) => print('← ${info.status} em ${info.duration.inMilliseconds}ms'),
    onRetry: (info) => print('retry em ${info.delay.inMilliseconds}ms: ${info.reason}'),
  ),
);
```

## Transporte plugável

O HTTP é feito pelo `package:http` (`HttpTransport`), mas a interface `Transport`
permite trocar a camada inteira (proxy corporativo, Dio, mocks de teste):

```dart
import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';
import 'package:http/http.dart' as http;

final api = ApiBrasil(
  bearerToken: '...',
  transport: HttpTransport(
    client: http.Client()
      ..timeout = Duration(seconds: 60)
      ..findProxy = (uri) => 'PROXY http://proxy.local:3128',
  ),
);
```

Ou implemente a sua:

```dart
import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';

class MeuTransporte implements Transport {
  @override
  Future<TransportResponse> send(TransportRequest request) async {
    // use o cliente HTTP que quiser e devolva status, headers e corpo
    return TransportResponse(200, {}, {'ok': true});
  }

  @override
  void close() {}
}
```

## Catálogo gerado

As actions de WhatsApp/Evolution/WhatsMeow e os 210+ `tipo` de consulta estão
disponíveis em constantes geradas do catálogo real da plataforma
(regenerar futuramente via tooling):

```dart
import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';

Catalog.whatsappActions;              // ['sendText', 'sendFile', ...]
Catalog.serviceActions('whatsmeow');  // actions documentadas do serviço
Catalog.consultaTipo('lista-socios'); // {service: 'cnpj', fields: ['cnpj']}
```

## Endpoint sem método dedicado?

Todo o gateway fica acessível pela porta de saída genérica, já com seus headers de autenticação:

```dart
await api.request('POST', '/consulta/cpf/credits', {'cpf': '00000000000'});
await api.request('GET', '/reports/quick-stats');
```

Documentação completa dos endpoints: https://doc.apibrasil.io

## Configuração avançada

```dart
final api = ApiBrasil(
  bearerToken: '...',                    // ou APIBRASIL_BEARER_TOKEN
  deviceToken: '...',                    // ou APIBRASIL_DEVICE_TOKEN
  secretKey: '...',                      // usada em devices->store (ou APIBRASIL_SECRET_KEY)
  baseUrl: 'https://gateway.apibrasil.io/api/v2', // padrão (ou APIBRASIL_BASE_URL)
  timeout: Duration(seconds: 30),
  headers: {'X-Custom': 'valor'},        // headers extras
  retry: RetryConfig(retries: 2),        // ou RetryConfig.disabled
  hooks: ApiBrasilHooks(
    onRetry: (info) => print(info.reason),
  ),
  transport: null,                       // Transport customizado
);
```

Opções por requisição (último parâmetro de qualquer método): `query`, `headers`,
`bearerToken`, `deviceToken`, `secretKey`, `timeout`, `responseType`.

```dart
await api.whatsapp.sendText(
  {'number': '5511999999999', 'text': 'Olá!'},
  RequestOptions(
    deviceToken: 'OUTRO_DEVICE',
    timeout: Duration(minutes: 1),
  ),
);
```

> **Atenção:** `timeout` é em **Duration** (padrão Dart), diferente da interface legada do PHP que usa segundos.

## Interface legada (compatibilidade)

As classes `ApiService`, `WhatsAppService`, `CpfService`, `SmsService` continuam funcionando exatamente como antes (resposta em `Map`, erros como exceção), mas estão **depreciadas** — prefira o cliente `ApiBrasil`.

```dart
// Legado (compatibilidade)
final legacy = WhatsAppService(bearerToken: '...', deviceToken: '...');
await legacy.sendText(ApiRequest(
  credentials: Credentials(deviceToken: '...', bearerToken: '...'),
  body: Body(text: 'Olá', number: '5511999999999', timeTyping: 1000),
));
```

## Mais informações

https://pub.dev/packages/apigratis_sdk_flutter