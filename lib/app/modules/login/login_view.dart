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
    return Scaffold(
      body: VStack(
        [
          Text(
            'Welcome to ${PreferenceHelper.getCurrentAppName()} Apps',
            style: GoogleFonts.aBeeZee(
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          12.heightBox,
          Text(
            'Interactive learning for children with special needs',
            style: GoogleFonts.aBeeZee(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          48.heightBox,
          ExTextFieldIcon(
            prefixIcon: Icons.person_2_rounded,
            labelText: 'Enter teacher name',
            hint: 'Teacher Name',
            tfController: controller.teacherController,
            textInputType: TextInputType.name,
          ),
          64.heightBox,
          ExButtonDefault(
            label: 'Enter',
            labelSize: 32,
            height: 64,
            onPressed: () => controller.saveTeacherName(),
          ).wFull(context)
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ).paddingSymmetric(horizontal: 265).centered(),
    );
  }
}
