import 'package:andin_project/app/core/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('light application theme remains readable on device dark mode', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
        home: const Scaffold(body: Center(child: Text('Question screen'))),
      ),
    );

    expect(find.text('Question screen'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.text('Question screen'))).brightness,
      Brightness.light,
    );
  });
}
