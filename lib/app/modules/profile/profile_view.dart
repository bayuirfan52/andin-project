import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:andin_project/app/widgets/ex_textfield_normal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:velocity_x/velocity_x.dart';

import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        body: Center(
          child: VStack(
            [
              Text(
                'text_teacher_name'.tr,
                style: GoogleFonts.aBeeZee(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              48.heightBox,
              ExTextFieldNormal(
                hint: 'text_teacher_name'.tr,
                textAlign: TextAlign.center,
                tfController: controller.teacherController,
              ),
              128.heightBox,
              ExButtonDefault(
                label: 'button_change'.tr,
                labelSize: 32,
                height: 64,
                onPressed: () => ExDialog.alertDialog(
                  title: 'text_alert'.tr,
                  message: 'text_alert_change_name'.tr,
                  onConfirmClicked: () => controller.saveNewName(),
                ),
              ).wFull(context)
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(v: 24, h: 128).scrollVertical(),
        ),
        bottomNavigationBar: VStack(
          [
            Text(
              'text_select_language'.tr,
              style: GoogleFonts.aBeeZee(fontSize: 24),
            ),
            24.heightBox,
            Obx(
              () => ToggleSwitch(
                totalSwitches: 2,
                initialLabelIndex: controller.currentLocale.value,
                minWidth: 128,
                fontSize: 18,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                animate: true,
                animationDuration: 200,
                activeBgColor: const [colorPrimary, colorPrimary],
                labels: const ['Indonesia', 'English (US)'],
                onToggle: (index) {
                  logD('clicked $index');
                  controller.changeLanguage(index);
                },
              ),
            )
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).p24(),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        body: Center(
          child: VStack(
            [
              Text(
                'text_teacher_name'.tr,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              12.heightBox,
              ExTextFieldNormal(
                hint: 'text_teacher_name'.tr,
                textAlign: TextAlign.center,
                hintSize: 12,
                size: 12,
                tfController: controller.teacherController,
              ),
              12.heightBox,
              ExButtonDefault(
                label: 'button_change'.tr,
                labelSize: 12,
                onPressed: () => ExDialog.alertDialog(
                  title: 'text_alert'.tr,
                  message: 'text_alert_change_name'.tr,
                  onConfirmClicked: () => controller.saveNewName(),
                ),
              ).wFull(context)
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(v: 12, h: 128).scrollVertical(),
        ),
        bottomNavigationBar: VStack(
          [
            Text(
              'text_select_language'.tr,
              style: GoogleFonts.aBeeZee(fontSize: 16),
            ),
            8.heightBox,
            Obx(
              () => ToggleSwitch(
                totalSwitches: 2,
                initialLabelIndex: controller.currentLocale.value,
                minWidth: 128,
                fontSize: 12,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                animate: true,
                animationDuration: 200,
                activeBgColor: const [colorPrimary, colorPrimary],
                labels: const ['Indonesia', 'English (US)'],
                onToggle: (index) {
                  logD('clicked $index');
                  controller.changeLanguage(index);
                },
              ),
            )
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).p12(),
      );
}
