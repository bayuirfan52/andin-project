import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:flutter/material.dart';

enum BSHeaderType { dash, close }

enum BSContentType { regular, radio }

mixin DecoratorHelper {
  static BoxDecoration boxBottomSheetRadiusDecoration({double radius = 16}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }

  static BoxDecoration commonBoxDecoration({
    Color? borderColor = colorPrimary,
    Color? fillColor = Colors.transparent,
    double borderRadius = 4,
  }) {
    return BoxDecoration(
      color: fillColor,
      border: Border.all(color: borderColor ?? colorPrimary),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static BoxDecoration commonBoxDecorationWithShadow({
    Color? borderColor = colorPrimary,
    Color? fillColor = Colors.white,
    double borderRadius = 0.0,
  }) {
    return BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[200]!,
          spreadRadius: 10,
          blurRadius: 10,
          offset: const Offset(3, 3),
        ),
      ],
    );
  }
}
