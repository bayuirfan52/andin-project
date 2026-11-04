import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: colorPrimary,
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onSecondary: colorPrimary,
      error: Colors.red,
      secondary: colorPrimary,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.aBeeZeeTextTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorPrimary,
      elevation: 1.0,
      titleTextStyle: GoogleFonts.aBeeZee(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
