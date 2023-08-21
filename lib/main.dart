import 'dart:async';

import 'package:andin_project/app/core/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await FlutterConfig.loadEnvVariables();
      await GetStorage.init();
      runApp(AndinProject());
    },
    (error, stack) {},
  );
}

class AndinProject extends StatelessWidget {
  const AndinProject({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Andin Project',
        theme: AppTheme.theme,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.native,
        builder: (context, child) {
          if (FlutterConfig.get('FLAVOR') == 'production') {
            return child!;
          } else {
            return Scaffold(
              body: Stack(
                children: [
                  child!,
                  Positioned(
                    top: 55,
                    right: 55,
                    child: HStack([
                      Icon(Icons.bug_report, color: Vx.blue300),
                      4.widthBox,
                    ]).onInkTap(
                      () => {},
                    ),
                  ),
                ],
              ),
            );
          }
        },
      );
}
