import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

mixin ExDialog {
  static void alertDialog({required String message, required Function onConfirmClicked, String? title, bool isTablet = true}) {
    Get.defaultDialog<dynamic>(
      title: title ?? '',
      titleStyle: GoogleFonts.aBeeZee(
        fontSize: isTablet ? 32 : 16,
        fontWeight: FontWeight.w700,
      ),
      titlePadding: EdgeInsets.all(12),
      content: Text(
        message,
        style: GoogleFonts.aBeeZee(fontSize: isTablet ? 24 : 16),
        textAlign: TextAlign.center,
      ).p12(),
      confirmTextColor: Colors.white,
      textConfirm: 'button_yes'.tr,
      textCancel: 'button_cancel'.tr,
      onConfirm: () {
        Get.back<dynamic>();
        onConfirmClicked.call();
      },
      onCancel: () => {},
    );
  }
}
