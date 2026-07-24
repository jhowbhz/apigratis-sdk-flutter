import 'dart:io' show Platform;

/// Variáveis de ambiente do processo (Dart puro, Flutter mobile/desktop).
Map<String, String> get platformEnvironment => Platform.environment;
