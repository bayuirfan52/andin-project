import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTheme {
  static final theme = ThemeData(
    primaryColor: colorPrimary,
    colorScheme: ColorScheme.light(primary: colorPrimary, error: Colors.red),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.aBeeZeeTextTheme(),
    appBarTheme: AppBarTheme(
      color: colorPrimary,
      elevation: 1.0,
      titleTextStyle: GoogleFonts.aBeeZee(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
