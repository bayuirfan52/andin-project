import 'dart:io';

import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
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
    return Obx(() => controller.isTablet.value ? tabletUI(context) : phoneUI(context));
  }

  Widget phoneUI(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Obx(
            () => HStack([
              Text(
                '${controller.currentLevel.value == 1 ? (controller.level1.value.question ?? '') : (controller.level2.value.question ?? '')} | ',
                style: GoogleFonts.aBeeZee(fontSize: 16),
              ),
              Text(
                'text_current_score_'.trParams({'score': '${controller.currentScore.value}/650'}),
                style: GoogleFonts.aBeeZee(fontSize: 16),
              ),
            ]),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 24),
              child: Text(
                'text_student_'.trParams({'name': controller.currentStudent.value.studentName ?? ''}),
                textAlign: TextAlign.end,
              ).centered(),
            ),
          ],
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.5,
                image: AssetImage('assets/images/img_background.jpg'),
              ),
            ),
            child: HStack(
              [
                VStack(
                  [
                    Text(
                      'text_score'.tr,
                      style: GoogleFonts.aBeeZee(fontSize: 16),
                    ),
                    VStack([
                      MaterialButton(
                        color: Colors.red.shade500,
                        onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(0) : showAlertReachMaxCount(),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '0',
                          style: GoogleFonts.aBeeZee(color: Colors.white),
                        ),
                      ),
                      12.widthBox,
                      MaterialButton(
                        color: Colors.orange.shade500,
                        onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(30) : showAlertReachMaxCount(),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '30',
                          style: GoogleFonts.aBeeZee(color: Colors.white),
                        ),
                      ),
                      12.widthBox,
                      MaterialButton(
                        color: Colors.green.shade500,
                        onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(60) : showAlertReachMaxCount(),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '60',
                          style: GoogleFonts.aBeeZee(color: Colors.white),
                        ),
                      ),
                      12.widthBox,
                      MaterialButton(
                        color: Colors.blue.shade500,
                        onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(80) : showAlertReachMaxCount(),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '80',
                          style: GoogleFonts.aBeeZee(color: Colors.white),
                        ),
                      ),
                    ]),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                ),
                Obx(() => controller.currentLevel.value == 1 ? questionLevel1(context) : questionLevel2(context)),
                Container(
                  width: 80,
                ),
              ],
              alignment: MainAxisAlignment.spaceAround,
            ).wFull(context),
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
                label: 'button_previous'.tr,
                labelSize: 16,
                height: 40,
              ),
            ),
            Obx(
              () => HStack(
                [
                  Text(
                    controller.currentPlayedAnswer.value,
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ).pSymmetric(h: 128).pOnly(bottom: 12),
            ),
            Obx(
              () => ExButtonDefault(
                width: 164,
                backgroundColor: colorPrimary,
                isEnable: controller.isHasNextQuestion.value,
                onPressed: () => controller.nextQuestion(),
                label: 'button_next'.tr,
                labelSize: 16,
                height: 40,
              ),
            ),
          ],
          alignment: MainAxisAlignment.spaceBetween,
          crossAlignment: CrossAxisAlignment.end,
        ).p12(),
      );

  Widget tabletUI(BuildContext context) => Scaffold(
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
                'button_select_student'.tr,
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
                () => HStack(
                  [
                    Text(
                      'text_current_score_'.trParams({'score': controller.currentScore.value.toString()}),
                      textScaleFactor: 1.5,
                    ).expand(),
                    Text(
                      controller.currentPlayedAnswer.value,
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center,
                    ).expand(),
                    Text(
                      'text_student_'.trParams({'name': controller.currentStudent.value.studentName ?? ''}),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.end,
                    ).expand(),
                  ],
                ).pSymmetric(h: 128),
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
                label: 'button_previous'.tr,
                labelSize: 36,
                height: 80,
              ),
            ),
            VStack(
              [
                Obx(
                  () => Text(
                    controller.isAnswered.value ? 'text_question_scored'.trParams({'count': (10 - (controller.currentAnswer.value.count ?? 0)).toString()}) : 'text_score'.tr,
                    style: GoogleFonts.aBeeZee(fontSize: 36),
                  ),
                ),
                24.heightBox,
                HStack([
                  MaterialButton(
                    color: Colors.red.shade500,
                    onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(0) : showAlertReachMaxCount(),
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
                    onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(30) : showAlertReachMaxCount(),
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
                    onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(60) : showAlertReachMaxCount(),
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
                    onPressed: () => (controller.currentAnswer.value.count ?? 0) < 10 ? saveAnswerDialog(80) : showAlertReachMaxCount(),
                    padding: EdgeInsets.all(24),
                    child: Text(
                      '80',
                      textScaleFactor: 2,
                      style: GoogleFonts.aBeeZee(color: Colors.white),
                    ),
                  ),
                ]),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ),
            Obx(
              () => ExButtonDefault(
                width: 164,
                backgroundColor: colorPrimary,
                isEnable: controller.isHasNextQuestion.value,
                onPressed: () => controller.nextQuestion(),
                label: 'button_next'.tr,
                labelSize: 36,
                height: 80,
              ),
            ),
          ],
          alignment: MainAxisAlignment.spaceBetween,
          crossAlignment: CrossAxisAlignment.end,
        ).p24(),
      );

  void saveAnswerDialog(int score) {
    ExDialog.alertDialog(
      title: 'text_attention'.tr,
      message: 'text_alert_add_score'.trParams({'score': score.toString(), 'name': controller.currentStudent.value.studentName ?? ''}),
      onConfirmClicked: () => controller.saveAnswer(score),
      isTablet: controller.isTablet.value,
    );
  }

  void showAlertReachMaxCount() {
    FlushbarHelper.showFlushbar(Get.context!, message: 'text_react_max_count_alert'.tr, title: 'text_attention'.tr, type: FlushbarType.WARNING);
  }

  Widget questionLevel1(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorBorder),
        ),
        child: Obx(() {
          if (controller.level1.value.isDefault ?? true) {
            return Image.asset(
              controller.level1.value.imagePath1 ?? '',
              width: controller.isTablet.value ? 256 : 256,
              height: controller.isTablet.value ? 256 : 196,
              isAntiAlias: true,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                logE('$error - ${stackTrace}');
                return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
              },
            ).onInkTap(() => controller.play(controller.level1.value.answer1 ?? '', controller.level1.value.audioPath1 ?? '', 1, isDefault: true)).p12();
          } else {
            return Image.file(
              File(controller.level1.value.imagePath1 ?? ''),
              width: controller.isTablet.value ? 256 : 256,
              height: controller.isTablet.value ? 256 : 196,
              isAntiAlias: true,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                logE('$error - ${stackTrace}');
                return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
              },
            ).onInkTap(() => controller.play(controller.level1.value.answer1 ?? '', controller.level1.value.audioPath1 ?? '', 1)).p12();
          }
        }),
      );

  Widget questionLevel2(BuildContext context) => HStack([
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorBorder),
          ),
          child: HStack([
            Obx(() {
              if (controller.level2.value.isDefault ?? true) {
                return Image.asset(
                  controller.level2.value.imagePath1 ?? '',
                  width: controller.isTablet.value ? 256 : 256,
                  height: controller.isTablet.value ? 256 : 196,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    logE('$error - ${stackTrace}');
                    return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                  },
                ).onInkTap(() => controller.play(controller.level2.value.answer1 ?? '', controller.level2.value.audioPath1 ?? '', 1, isDefault: true)).p12();
              } else {
                return Image.file(
                  File(controller.level2.value.imagePath1 ?? ''),
                  width: controller.isTablet.value ? 256 : 256,
                  height: controller.isTablet.value ? 256 : 196,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    logE('$error - ${stackTrace}');
                    return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                  },
                ).onInkTap(() => controller.play(controller.level2.value.answer1 ?? '', controller.level2.value.audioPath1 ?? '', 1)).p12();
              }
            }),
          ]),
        ),
        12.widthBox,
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorBorder),
          ),
          child: HStack([
            Obx(() {
              if (controller.level2.value.isDefault ?? true) {
                return Image.asset(
                  controller.level2.value.imagePath2 ?? '',
                  width: controller.isTablet.value ? 256 : 256,
                  height: controller.isTablet.value ? 256 : 196,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    logE('$error - ${stackTrace}');
                    return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                  },
                ).onInkTap(() => controller.play(controller.level2.value.answer2 ?? '', controller.level2.value.audioPath2 ?? '', 2, isDefault: true)).p12();
              } else {
                return Image.file(
                  File(controller.level2.value.imagePath2 ?? ''),
                  width: controller.isTablet.value ? 256 : 256,
                  height: controller.isTablet.value ? 256 : 196,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    logE('$error - ${stackTrace}');
                    return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                  },
                ).onInkTap(() => controller.play(controller.level2.value.answer2 ?? '', controller.level2.value.audioPath2 ?? '', 2)).p12();
              }
            }),
          ]),
        ),
      ]);
}
