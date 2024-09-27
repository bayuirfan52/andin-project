import 'dart:async';

import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/core/resources/app_theme.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:andin_project/generated/locales.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

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
      await Logger.init();
      await Database.databaseInit();
      GoogleFonts.config.allowRuntimeFetching = false;
      Get.lazyPut<GetStorage>(() => GetStorage());
      runApp(AndinProject());
    },
    (error, stack) {},
  );
}

class AndinProject extends StatefulWidget {
  const AndinProject({super.key});

  @override
  State<AndinProject> createState() => _AndinProjectState();
}

class _AndinProjectState extends State<AndinProject> {
  late Locale locale;

  @override
  void initState() {
    final languageCode = PreferenceHelper.getActiveLanguage();
    if (languageCode == null) {
      locale = Locale('id', 'ID');
    } else {
      final parseCode = languageCode.split('_');
      locale = Locale(parseCode[0], parseCode[1]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: PreferenceHelper.getCurrentAppName(),
        theme: AppTheme.theme,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
        // ignore: avoid_redundant_argument_values
        debugShowCheckedModeBanner: kDebugMode,
        translationsKeys: AppTranslation.translations,
        locale: locale,
        fallbackLocale: Locale('id', 'ID'),
        builder: (context, child) {
          return FutureBuilder(
            future: DeviceUtil.isTablet(context),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                PreferenceHelper.setIsTablet(snapshot.data!);
                if (FlutterConfig.get('FLAVOR') == 'production') {
                  return child!;
                } else {
                  return Scaffold(
                    body: Stack(
                      children: [
                        child!,
                        Positioned(
                          top: 95,
                          right: 55,
                          child: HStack([
                            Icon(Icons.bug_report, color: Vx.blue300),
                            4.widthBox,
                          ]).onInkTap(
                            () => Get.toNamed<dynamic>(Routes.DEV_TOOLS),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Container();
              }
            },
          );
        },
      );
}
