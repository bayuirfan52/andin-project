import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/helper/decorator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

mixin BottomSheetHelper {
  static void bottomSheetCommon({required Widget children, String title = ''}) {
    HapticFeedback.lightImpact();
    Get.bottomSheet<dynamic>(
      DecoratedBox(
        decoration: DecoratorHelper.boxBottomSheetRadiusDecoration(),
        child: VStack([
          const Center(
            child: SizedBox(
              width: 90,
              child: Divider(
                thickness: 3,
                color: colorDivider,
              ),
            ),
          ),
          16.heightBox,
          if (title.isNotEmpty)
            VStack([
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              10.heightBox,
            ]),
          children
        ]).p16(),
      ),
      elevation: 10,
      isScrollControlled: true,
    );
  }
}
