import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:andin_project/app/widgets/ex_textfield_normal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'edit_student_controller.dart';

class EditStudentView extends GetView<EditStudentController> {
  const EditStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VStack(
          [
            Text(
              'text_edit_student'.tr,
              style: GoogleFonts.aBeeZee(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            48.heightBox,
            ExTextFieldNormal(
              hint: 'text_student_name'.tr,
              capitalization: TextCapitalization.words,
              textAlign: TextAlign.center,
              tfController: controller.studentController,
            ),
            128.heightBox,
            ExButtonDefault(
              label: 'button_save'.tr,
              labelSize: 32,
              height: 64,
              onPressed: () => ExDialog.alertDialog(
                title: 'text_alert'.tr,
                message: 'text_alert_edit_student'.tr,
                onConfirmClicked: () => controller.saveStudent(),
              ),
            ).wFull(context)
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).pSymmetric(v: 24, h: 128).scrollVertical(),
      ),
    );
  }
}
