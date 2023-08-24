import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:andin_project/app/widgets/ex_textfield_normal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VStack(
          [
            Text(
              'Teacher Name',
              style: GoogleFonts.aBeeZee(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            48.heightBox,
            ExTextFieldNormal(
              hint: 'Teacher Name',
              textAlign: TextAlign.center,
              tfController: controller.teacherController,
            ),
            128.heightBox,
            ExButtonDefault(
              label: 'Change',
              labelSize: 32,
              height: 64,
              onPressed: () => ExDialog.alertDialog(
                title: 'Alert',
                message: 'Are you sure to change your name?',
                onConfirmClicked: () => controller.saveNewName(),
              ),
            ).wFull(context)
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).pSymmetric(v: 24, h: 128).scrollVertical(),
      ),
    );
  }
}
