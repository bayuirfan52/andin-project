import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
import 'package:andin_project/app/widgets/ex_textfield_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'add_student_controller.dart';

class AddStudentView extends GetView<AddStudentController> {
  const AddStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget tabletUI(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: VStack(
            [
              Text(
                'button_add_new_student'.tr,
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
                label: 'button_add'.tr,
                labelSize: 32,
                height: 64,
                onPressed: () => ExDialog.alertDialog(
                  title: 'text_alert'.tr,
                  message: 'text_alert_add_student'.tr,
                  onConfirmClicked: () => controller.saveNewStudent(),
                ),
              ).wFull(context),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(v: 24, h: 128).scrollVertical(),
        ),
      );

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: VStack(
            [
              Text(
                'button_add_new_student'.tr,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              24.heightBox,
              ExTextFieldNormal(
                hint: 'text_student_name'.tr,
                capitalization: TextCapitalization.words,
                textAlign: TextAlign.center,
                hintSize: 12,
                size: 12,
                tfController: controller.studentController,
              ),
              48.heightBox,
              ExButtonDefault(
                label: 'button_add'.tr,
                labelSize: 12,
                onPressed: () => ExDialog.alertDialog(
                  title: 'text_alert'.tr,
                  message: 'text_alert_add_student'.tr,
                  isTablet: false,
                  onConfirmClicked: () => controller.saveNewStudent(),
                ),
              ).wFull(context),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).pSymmetric(v: 24, h: 128).scrollVertical(),
        ),
      );
}
