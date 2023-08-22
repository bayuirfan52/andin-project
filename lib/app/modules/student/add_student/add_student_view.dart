import 'package:andin_project/app/widgets/ex_button_default.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VStack(
          [
            Text(
              'Add Student',
              style: GoogleFonts.aBeeZee(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            48.heightBox,
            ExTextFieldNormal(
              hint: 'Student Name',
              textAlign: TextAlign.center,
              tfController: controller.studentController,
            ),
            128.heightBox,
            ExButtonDefault(
              label: 'Add',
              labelSize: 32,
              height: 64,
              onPressed: () => {},
            ).wFull(context)
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).pSymmetric(v: 24, h: 128),
      ),
    );
  }
}
