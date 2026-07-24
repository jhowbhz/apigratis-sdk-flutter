import 'package:apigratis_sdk_flutter/apigratis_sdk_flutter.dart';

/// Exemplo básico de uso da SDK APIBrasil.
///
/// Defina as credenciais por variável de ambiente antes de rodar:
///
/// ```sh
/// export APIBRASIL_BEARER_TOKEN="seu_bearer_token"
/// export APIBRASIL_DEVICE_TOKEN="seu_device_token"
/// dart run example/apigratis_sdk_flutter_example.dart
/// ```
Future<void> main() async {
  // Sem argumentos, as credenciais são lidas do ambiente
  // (APIBRASIL_BEARER_TOKEN / APIBRASIL_DEVICE_TOKEN).
  final api = ApiBrasil();

  try {
    // Consulta de CEP
    final cep = await api.cep.cep({'cep': '01001000'});
    print('CEP: $cep');

    // Envio de mensagem no WhatsApp
    final message = await api.whatsapp.sendText({
      'number': '5511999999999',
      'text': 'Olá, mundo!',
    });
    print('WhatsApp: $message');

    // Saldo da conta
    final balance = await api.account.balance();
    print('Saldo: $balance');
  } on AuthenticationError catch (e) {
    print('Credenciais inválidas: ${e.message}');
  } on InsufficientBalanceError catch (e) {
    print('Saldo insuficiente: ${e.message}');
  } on ApiBrasilError catch (e) {
    print('Erro da API (${e.status}): ${e.message}');
  } finally {
    api.close();
  }
}
