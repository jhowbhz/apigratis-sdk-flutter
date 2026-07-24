# Changelog

## 0.1.0 — 2026-07-23

Novo cliente `ApiBrasil` cobrindo toda a plataforma APIBrasil — mesma
arquitetura, mesmos endpoints e mesmas funções da SDK PHP/Node.js. Release
totalmente retrocompatível: nada da interface antiga foi alterado.

### Novidades

- **Cliente central `ApiBrasil`** com módulos por produto: `whatsapp`, `evolution`, `whatsmeow`, `sms`, `dados`, `vehicles`, `fipe`, `correios`, `cep`, `geolocation`, `geomatrix`, `recognize`, `ddd`, `holidays`, `translate`, `weather`, `loterias`, `databaseIp`, `consulta` (créditos), `ura`, `chipVirtual`, `bulk`, `auth` (login/2FA), `devices`, `catalog`, `account`, `payments` (PIX/boleto/cartão), `ipWhitelist`, `bearerRateLimit`, `reports`.
- **Transporte plugável** (`Transport` interface): `HttpTransport` (package:http) por padrão, injeção de implementações próprias para proxies e mocks.
- **Retry com backoff exponencial** (padrão: HTTP 429 e falhas de conexão; nunca timeouts nem erros de negócio) com suporte a `Retry-After`.
- **Hooks de observabilidade**: `onRequest`, `onResponse`, `onRetry`.
- **Hierarquia de erros**: `ValidationError`, `AuthenticationError`, `InsufficientBalanceError`, `PermissionError`, `NotFoundError`, `RateLimitError`, `ServerError`, `NetworkError`, `TimeoutError` — todas estendendo `ApiBrasilError`.
- **Variáveis de ambiente / `--dart-define`**: `APIBRASIL_BEARER_TOKEN`, `APIBRASIL_DEVICE_TOKEN`, `APIBRASIL_SECRET_KEY`, `APIBRASIL_BASE_URL` lidas automaticamente.
- **Catálogo gerado**: `Catalog.whatsappActions`, `Catalog.evolutionPaths`, `Catalog.whatsmeowActions`, `Catalog.consultaServicos`, `Catalog.consultaTipos` (210+ tipos) e `Catalog.serviceActions`.
- **Interface legada preservada**: `ApiService`, `LegacyWhatsAppService`, `LegacyCpfService`, `LegacySmsService` mantêm o mesmo contrato da 0.0.x (sempre `POST`, resposta `Map`, erros como exceção). Marcadas como `@Deprecated` — prefira `ApiBrasil()`.

### Correções

- Todos os serviços agora **compartilham um único `ApiHttpClient`**. Antes cada
  um criava o seu, então `setBearerToken()` (ex.: após `auth.login()`) não
  valia para os demais módulos e `close()` deixava conexões abertas.
- Corrigidos os imports internos da biblioteca, que impediam a compilação do pacote.

### Mudanças incompatíveis (vindo da 0.0.9)

- Classes legadas renomeadas com o prefixo `Legacy` para liberar os nomes aos
  serviços novos: `WhatsAppService` → `LegacyWhatsAppService`, `CpfService` →
  `LegacyCpfService`, `SmsService` → `LegacySmsService`. `ApiService`,
  `ApiRequest`, `Credentials` e `Body` seguem com os nomes originais.
  Agora `WhatsAppService` e `SmsService` referem-se aos serviços novos
  (`api.whatsapp`, `api.sms`).

### Compatibilidade

- No cliente novo, `timeout` é `Duration` (paridade com Dart padrão). A interface legada continua em milissegundos diretos.
- As respostas do cliente novo são `Json` (`Map<String, dynamic>`); a interface legada continua devolvendo `Map<String, dynamic>`.

## 0.0.9 — 2025-XX-XX

- Fix parameter url

## 0.0.8 — 2025-XX-XX

- Fix parameter url

## 0.0.7 — 2025-XX-XX

- Fix parameter url

## 0.0.6 — 2025-XX-XX

- Fix parameter url

## 0.0.5 — 2025-XX-XX

- Fix code

## 0.0.4 — 2025-XX-XX

- Fix parameters request

## 0.0.3 — 2025-XX-XX

- Fix parameters request

## 0.0.2 — 2025-XX-XX

- Fix parameters

## 0.0.1 — 2025-XX-XX

- Initial version.