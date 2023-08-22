import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

mixin FlushbarHelper {
  static void showFlushbar(
    BuildContext context, {
    required String message,
    FlushbarType type = FlushbarType.INFO,
    String? title,
  }) {
    final icon = type == FlushbarType.SUCCESS
        ? Icons.check
        : type == FlushbarType.WARNING
            ? Icons.warning_rounded
            : type == FlushbarType.INFO
                ? Icons.info_rounded
                : Icons.error_rounded;

    final color = type == FlushbarType.SUCCESS
        ? Colors.green.shade500
        : type == FlushbarType.WARNING
            ? Colors.yellow.shade700
            : type == FlushbarType.INFO
                ? colorPrimary
                : Colors.red.shade500;

    Flushbar<dynamic>(
      title: title,
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
      margin: EdgeInsets.all(6.0),
      flushbarPosition: FlushbarPosition.TOP,
      textDirection: Directionality.of(context),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      titleColor: colorText,
      messageColor: colorText,
      leftBarIndicatorColor: color,
    ).show(context);
  }
}

enum FlushbarType { SUCCESS, WARNING, ERROR, INFO }
