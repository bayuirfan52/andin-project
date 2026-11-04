package com.bayuirfan.andin_project

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "andin_project/app_config",
        ).setMethodCallHandler { call, result ->
            if (call.method == "getConfig") {
                result.success(
                    mapOf(
                        "appName" to BuildConfig.APP_NAME,
                        "flavor" to BuildConfig.APP_FLAVOR,
                    ),
                )
            } else {
                result.notImplemented()
            }
        }
    }
}
