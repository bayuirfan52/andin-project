import 'dart:io';

import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:andin_project/app/widgets/ex_button_default.dart';
import 'package:andin_project/app/widgets/ex_dialog.dart';
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
          ),
        ],
      ),
      body: Center(
        child: VStack(
          [
            24.heightBox,
            Obx(
              () => Text(
                'Student: ${controller.currentStudent.value.studentName ?? ''}',
                textScaleFactor: 2,
                textAlign: TextAlign.end,
              ).wFull(context).pOnly(right: 128),
            ),
            Spacer(),
            Obx(() => controller.currentLevel.value == 1 ? questionLevel1(context) : questionLevel2(context)),
            Spacer(),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ),
      ),
      bottomNavigationBar: HStack(
        [
          Obx(
            () => ExButtonDefault(
              width: 164,
              backgroundColor: colorPrimary,
              isEnable: controller.isHasPreviousQuestion.value,
              onPressed: () => controller.previousQuestion(),
              label: 'Previous',
              labelSize: 36,
              height: 80,
            ),
          ),
          VStack(
            [
              Obx(
                () => Text(
                  controller.isAnswered.value ? 'This Question is Scored' : 'Score',
                  style: GoogleFonts.aBeeZee(fontSize: 36),
                ),
              ),
              24.heightBox,
              HStack([
                MaterialButton(
                  color: Colors.red.shade500,
                  onPressed: () => saveAnswerDialog(0),
                  padding: EdgeInsets.all(24),
                  child: Text(
                    '0',
                    textScaleFactor: 2,
                    style: GoogleFonts.aBeeZee(color: Colors.white),
                  ),
                ),
                12.widthBox,
                MaterialButton(
                  color: Colors.orange.shade500,
                  onPressed: () => saveAnswerDialog(30),
                  padding: EdgeInsets.all(24),
                  child: Text(
                    '30',
                    textScaleFactor: 2,
                    style: GoogleFonts.aBeeZee(color: Colors.white),
                  ),
                ),
                12.widthBox,
                MaterialButton(
                  color: Colors.green.shade500,
                  onPressed: () => saveAnswerDialog(60),
                  padding: EdgeInsets.all(24),
                  child: Text(
                    '60',
                    textScaleFactor: 2,
                    style: GoogleFonts.aBeeZee(color: Colors.white),
                  ),
                ),
                12.widthBox,
                MaterialButton(
                  color: Colors.blue.shade500,
                  onPressed: () => saveAnswerDialog(80),
                  padding: EdgeInsets.all(24),
                  child: Text(
                    '80',
                    textScaleFactor: 2,
                    style: GoogleFonts.aBeeZee(color: Colors.white),
                  ),
                ),
              ])
            ],
            crossAlignment: CrossAxisAlignment.center,
          ),
          Obx(
            () => ExButtonDefault(
              width: 164,
              backgroundColor: colorPrimary,
              isEnable: controller.isHasNextQuestion.value,
              onPressed: () => controller.nextQuestion(),
              label: 'Next',
              labelSize: 36,
              height: 80,
            ),
          ),
        ],
        alignment: MainAxisAlignment.spaceBetween,
        crossAlignment: CrossAxisAlignment.end,
      ).p24(),
    );
  }

  void saveAnswerDialog(int score) {
    ExDialog.alertDialog(
      title: 'Attention',
      message: 'Are you sure to add score $score for this question to ${controller.currentStudent.value.studentName}?',
      onConfirmClicked: () => controller.saveAnswer(score),
    );
  }

  Widget questionLevel1(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorBorder),
        ),
        child: Obx(
          () => Image.file(
            File(controller.level1.value.imagePath1 ?? ''),
            width: 256,
            height: 256,
            isAntiAlias: true,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              logE('$error - ${stackTrace}');
              return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
            },
          ).onInkTap(() => controller.play(controller.level1.value.audioPath1 ?? '', 1)).p12(),
        ),
      );

  Widget questionLevel2(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorBorder),
        ),
        child: HStack([
          Obx(
            () => Image.file(
              File(controller.level2.value.imagePath1 ?? ''),
              width: 256,
              height: 256,
              isAntiAlias: true,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                logE('$error - ${stackTrace}');
                return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
              },
            ).onInkTap(() => controller.play(controller.level1.value.audioPath1 ?? '', 1)).p12(),
          ),
          64.widthBox,
          Obx(
            () => Image.file(
              File(controller.level2.value.imagePath2 ?? ''),
              width: 256,
              height: 256,
              isAntiAlias: true,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                logE('$error - ${stackTrace}');
                return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
              },
            ).onInkTap(() => controller.play(controller.level1.value.audioPath1 ?? '', 1)).p12(),
          )
        ]),
      );
}
