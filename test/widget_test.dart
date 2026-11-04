import 'package:andin_project/app/core/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('application theme stays light when device requests dark mode', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
        home: const Scaffold(body: Text('Question')),
      ),
    );

    final context = tester.element(find.text('Question'));
    expect(Theme.of(context).brightness, Brightness.light);
    expect(Theme.of(context).scaffoldBackgroundColor, Colors.white);
  });
}
