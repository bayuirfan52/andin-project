import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig {
  AppConfig._();

  static const MethodChannel _channel =
      MethodChannel('andin_project/app_config');
  static String _appName = const String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Staging AVIC',
  );
  static String _flavor = const String.fromEnvironment(
    'APP_FLAVOR',
    defaultValue: 'staging',
  );

  static String get appName => _appName;
  static bool get isProduction => _flavor == 'production';

  static Future<void> initialize() async {
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }

    final config = await _channel.invokeMapMethod<String, String>('getConfig');
    final appName = config?['appName'];
    final flavor = config?['flavor'];
    if (appName == null || flavor == null) {
      throw StateError('Android did not provide the app flavor configuration.');
    }

    _appName = appName;
    _flavor = flavor;
  }
}
