import 'dart:developer' as developer;

import 'package:andin_project/app/utils/app_config.dart';

String _logName = AppConfig.appName;

class Logger {
  Logger._();

  static Future<void> init() async {
    developer.log('🤖 | $_logName is ready...', name: _logName);
  }
}

void log(dynamic message) {
  developer.log('🤖 | $message', name: _logName);
}

void logD(dynamic message) {
  developer.log('🤖 | $message', name: _logName);
}

void logE(dynamic message) {
  developer.log('🔴 | $message', name: _logName);
}

void logI(dynamic message) {
  developer.log('💻 | $message', name: _logName);
}

void logW(dynamic message) {
  developer.log('🟠 | $message', name: _logName);
}
