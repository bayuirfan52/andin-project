import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_textfield_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) {
    return Scaffold(
      body: VStack(
        [
          Text(
            'text_welcome_'.trParams({'app': PreferenceHelper.getCurrentAppName()}),
            style: GoogleFonts.aBeeZee(
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          12.heightBox,
          Text(
            'Autism visual communication for early student',
            style: GoogleFonts.aBeeZee(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          48.heightBox,
          ExTextFieldIcon(
            prefixIcon: Icons.person_2_rounded,
            labelText: 'text_enter_teacher_name'.tr,
            hint: 'text_teacher_name'.tr,
            tfController: controller.teacherController,
            textInputType: TextInputType.text,
            capitalization: TextCapitalization.words,
          ),
          64.heightBox,
          ExButtonDefault(
            label: 'button_enter'.tr,
            labelSize: 32,
            height: 64,
            onPressed: () => controller.saveTeacherName(),
          ).wFull(context),
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ).paddingSymmetric(horizontal: 265).centered(),
    ).safeArea();
  }

  Widget phoneUI(BuildContext context) {
    return Scaffold(
      body: VStack(
        [
          32.heightBox,
          Text(
            'text_welcome_'.trParams({'app': PreferenceHelper.getCurrentAppName()}),
            style: GoogleFonts.aBeeZee(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          12.heightBox,
          Text(
            'Autism visual communication for early student',
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          48.heightBox,
          ExTextFieldIcon(
            prefixIcon: Icons.person_2_rounded,
            labelText: 'text_enter_teacher_name'.tr,
            hint: 'text_teacher_name'.tr,
            size: 12,
            hintSize: 12,
            tfController: controller.teacherController,
            textInputType: TextInputType.text,
            capitalization: TextCapitalization.words,
          ),
          24.heightBox,
          ExButtonDefault(
            label: 'button_enter'.tr,
            labelSize: 12,
            onPressed: () => controller.saveTeacherName(),
          ).wFull(context),
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ).paddingSymmetric(horizontal: 265).centered().scrollVertical(),
    ).safeArea();
  }
}
