import 'package:andin_project/app/widgets/ex_textfield_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'select_student_controller.dart';

class SelectStudentView extends GetView<SelectStudentController> {
  const SelectStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VStack(
          [
            48.heightBox,
            Text(
              'Select Student',
              style: GoogleFonts.aBeeZee(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            48.heightBox,
            ExTextFieldIcon(
              prefixIcon: Icons.search_rounded,
              hint: 'Search',
              textAlign: TextAlign.center,
            )
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).pSymmetric(h: 128, v: 24).hFull(context),
      ),
    );
  }
}
