import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'question_detail_controller.dart';

class QuestionDetailView extends GetView<QuestionDetailController> {
  const QuestionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.currentLevel.value == 1 ? (controller.level1.value.question ?? '') : (controller.level2.value.question ?? ''),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () => controller.goToSelectStudent(),
            child: Text(
              'Select Student',
              textScaleFactor: 1.5,
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: VStack(
          [
            HStack(
              [
                Text(
                  'Current Active Student : ',
                  style: GoogleFonts.aBeeZee(fontSize: 24),
                ),
                Obx(
                  () => Text(
                    controller.currentStudent.value.studentName ?? '',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              alignment: MainAxisAlignment.center,
            ),
            128.heightBox,
            Text(
              'Under Construction',
              style: TextStyle(fontSize: 20),
            ),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ).p24(),
      ),
    );
  }
}
