#!/usr/bin/env dart
// Gera lib/src/generated/catalog.dart a partir do catálogo público do
// gateway APIBrasil (`GET /api/v2/documentations`).
//
// Uso:
//   dart run tool/codegen.dart
//   APIBRASIL_BASE_URL=... dart run tool/codegen.dart   # outra base
library;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

final String baseUrl = Platform.environment['APIBRASIL_BASE_URL'] ??
    'https://gateway.apibrasil.io/api/v2';

const String outputPath = 'lib/src/generated/catalog.dart';

String quote(String value) =>
    "'${value.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'";

/// Converte um valor do catálogo em um identificador Dart lowerCamelCase.
/// Devolve `null` quando o valor não vira um nome limpo (query strings,
/// placeholders `<...>` etc.) — nesse caso ele fica apenas na lista.
String? toIdentifier(String value) {
  if (value.contains('?') || value.contains('<') || value.contains('=')) return null;

  final words = value
      .split(RegExp(r'[^A-Za-z0-9]+'))
      .where((word) => word.isNotEmpty)
      .toList();
  if (words.isEmpty) return null;

  final buffer = StringBuffer();
  for (var i = 0; i < words.length; i++) {
    final word = words[i];
    // Preserva o camelCase interno já usado pelo gateway (sendText).
    final head = i == 0 ? word[0].toLowerCase() : word[0].toUpperCase();
    buffer.write(head + word.substring(1));
  }

  final identifier = buffer.toString();
  if (identifier.isEmpty) return null;
  if (RegExp(r'^[0-9]').hasMatch(identifier)) return null;
  return _dartKeywords.contains(identifier) ? '${identifier}Action' : identifier;
}

const Set<String> _dartKeywords = {
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue', 'default',
  'do', 'else', 'enum', 'extends', 'false', 'final', 'finally', 'for', 'if',
  'in', 'is', 'new', 'null', 'rethrow', 'return', 'super', 'switch', 'this',
  'throw', 'true', 'try', 'var', 'void', 'while', 'with', 'dynamic', 'values',
  'index', 'hashCode', 'runtimeType', 'toString', 'noSuchMethod',
};

/// Emite uma classe de constantes com autocomplete para os valores dados.
String renderConstants(String className, String doc, List<String> values) {
  final sorted = [...values]..sort();
  final used = <String>{};
  final lines = <String>[];

  for (final value in sorted) {
    var identifier = toIdentifier(value);
    if (identifier == null) continue;
    var candidate = identifier;
    var suffix = 2;
    while (!used.add(candidate)) {
      candidate = '$identifier$suffix';
      suffix++;
    }
    lines.add('  static const String $candidate = ${quote(value)};');
  }

  final all = sorted.map(quote).join(',\n    ');

  return '''
/// $doc
abstract final class $className {
${lines.join('\n')}

  /// Todos os valores conhecidos, em ordem alfabética.
  static const List<String> all = <String>[
    $all,
  ];
}
''';
}

Future<void> main() async {
  stdout.writeln('Baixando catálogo de $baseUrl/documentations ...');
  final response = await http.get(
    Uri.parse('$baseUrl/documentations'),
    headers: {
      'Accept': 'application/json',
      'User-Agent': 'APIBRASIL/SDK-DART codegen',
    },
  );
  if (response.statusCode != 200) {
    stderr.writeln('Falha ao baixar o catálogo: HTTP ${response.statusCode}');
    exitCode = 1;
    return;
  }

  final payload = jsonDecode(utf8.decode(response.bodyBytes));
  final documentations = payload is Map && payload['documentations'] is List
      ? payload['documentations'] as List
      : payload is List
          ? payload
          : null;
  if (documentations == null) {
    stderr.writeln('Resposta inesperada: "documentations" não é uma lista.');
    exitCode = 1;
    return;
  }

  /// service → actions (caminho após /api/v2/{service}/)
  final serviceActions = <String, Set<String>>{};

  /// tipo → { service, fields } das consultas por crédito
  final consultaTipos = <String, ({String service, List<String> fields})>{};
  final consultaServicos = <String>{};
  var endpointCount = 0;

  for (final doc in documentations) {
    final endpoints = doc is Map ? doc['endpoints'] : null;
    if (endpoints is! List) continue;

    for (final endpoint in endpoints) {
      if (endpoint is! Map) continue;
      final url = endpoint['url'];
      if (url is! String) continue;
      final match = RegExp(r'/api/v2/(.+)$').firstMatch(url);
      if (match == null) continue;
      endpointCount++;

      final fullPath = match.group(1)!.replaceAll(RegExp(r'^/+|/+$'), '');
      final segments = fullPath.split('/');
      final service = segments.first;
      final action = segments.skip(1).join('/');
      if (service.isEmpty) continue;

      final actions = serviceActions.putIfAbsent(service, () => <String>{});
      if (action.isNotEmpty) actions.add(action);

      final consulta =
          RegExp(r'^consulta/([^/]+)/credits$').firstMatch(fullPath);
      if (consulta != null) {
        consultaServicos.add(consulta.group(1)!);
        final body = endpoint['body'];
        if (body is Map && body['tipo'] is String && (body['tipo'] as String).isNotEmpty) {
          final fields = body.keys
              .map((key) => '$key')
              .where((key) => key != 'tipo' && key != 'homolog')
              .toList()
            ..sort();
          consultaTipos[body['tipo'] as String] =
              (service: consulta.group(1)!, fields: fields);
        }
      }
    }
  }

  final sortedServices = serviceActions.keys.toList()..sort();
  final serviceActionsLiteral = sortedServices.map((service) {
    final actions = (serviceActions[service]!.toList()..sort()).map(quote).join(', ');
    return '    ${quote(service)}: <String>[$actions],';
  }).join('\n');

  final sortedTipos = consultaTipos.keys.toList()..sort();
  final consultaTiposLiteral = sortedTipos.map((tipo) {
    final meta = consultaTipos[tipo]!;
    final fields = meta.fields.map(quote).join(', ');
    return '    ${quote(tipo)}: ConsultaTipoInfo(\n'
        '      service: ${quote(meta.service)},\n'
        '      fields: <String>[$fields],\n'
        '    ),';
  }).join('\n');

  final content = '''
// ARQUIVO GERADO AUTOMATICAMENTE — não edite manualmente.
//
// Fonte: $baseUrl/documentations
// Regenerar: dart run tool/codegen.dart
//
// ${documentations.length} documentações, $endpointCount endpoints,
// ${consultaTipos.length} tipos de consulta conhecidos.
//
// ignore_for_file: lines_longer_than_80_chars

${renderConstants('WhatsAppActions', 'Actions conhecidas da API de WhatsApp (`POST /whatsapp/{action}`).', [...?serviceActions['whatsapp']])}
${renderConstants('EvolutionPaths', 'Caminhos conhecidos da Evolution API (`POST /evolution/{controller}/{action}`).', [...?serviceActions['evolution']])}
${renderConstants('WhatsMeowActions', 'Actions conhecidas do WhatsMeow (`POST /whatsmeow/{action}`).', [...?serviceActions['whatsmeow']])}
${renderConstants('ConsultaServicos', 'Serviços de consulta por crédito (`POST /consulta/{servico}/credits`).', consultaServicos.toList())}
${renderConstants('ConsultaTipos', 'Tipos de consulta conhecidos (campo `tipo` do body).', consultaTipos.keys.toList())}
/// Metadados de um tipo de consulta: serviço da rota e campos do body de
/// exemplo documentado.
class ConsultaTipoInfo {
  const ConsultaTipoInfo({required this.service, required this.fields});

  /// Serviço da rota (`/consulta/{service}/credits`).
  final String service;

  /// Campos do body de exemplo, fora `tipo` e `homolog`.
  final List<String> fields;

  @override
  String toString() => 'ConsultaTipoInfo(service: \$service, fields: \$fields)';
}

/// Catálogo do gateway APIBrasil, gerado da documentação pública.
abstract final class Catalog {
  /// Actions documentadas por serviço do gateway.
  static const Map<String, List<String>> serviceActions = <String, List<String>>{
$serviceActionsLiteral
  };

  /// Metadados por tipo de consulta por crédito.
  static const Map<String, ConsultaTipoInfo> consultaTipos =
      <String, ConsultaTipoInfo>{
$consultaTiposLiteral
  };

  /// Actions documentadas de um serviço (vazio se desconhecido).
  static List<String> actionsOf(String service) =>
      serviceActions[service] ?? const <String>[];
}
''';

  final file = File(outputPath);
  await file.parent.create(recursive: true);
  await file.writeAsString(content);
  stdout.writeln(
    'OK: $outputPath (${documentations.length} docs, $endpointCount endpoints, '
    '${consultaTipos.length} tipos)',
  );
}
