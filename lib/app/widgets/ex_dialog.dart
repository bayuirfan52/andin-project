import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

mixin ExDialog {
  static void alertDialog({required String message, required Function onConfirmClicked, String? title}) {
    Get.defaultDialog<dynamic>(
      title: title ?? '',
      titleStyle: GoogleFonts.aBeeZee(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      titlePadding: EdgeInsets.all(12),
      content: Text(
        message,
        style: GoogleFonts.aBeeZee(fontSize: 24),
        textAlign: TextAlign.center,
      ).p12(),
      confirmTextColor: Colors.white,
      textConfirm: 'Yes',
      onConfirm: () {
        Get.back<dynamic>();
        onConfirmClicked.call();
      },
      onCancel: () => {},
    );
  }
}
