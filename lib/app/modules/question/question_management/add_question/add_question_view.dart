import 'dart:io';

import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:andin_project/app/widgets/ex_image_view.dart';
import 'package:andin_project/app/widgets/ex_textfield_normal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:velocity_x/velocity_x.dart';

import 'add_question_controller.dart';

class AddQuestionView extends GetView<AddQuestionController> {
  const AddQuestionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () => controller.saveQuestion(),
            child: Text(
              'Save',
              textScaleFactor: 1.5,
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          )
        ],
      ),
      body: VStack([
        Text(
          'Enter Question Title',
          style: GoogleFonts.aBeeZee(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        16.heightBox,
        ExTextFieldNormal(
          hint: 'Question Title',
          tfController: controller.questionController,
          capitalization: TextCapitalization.words,
          textInputType: TextInputType.name,
        ),
        24.heightBox,
        Text(
          'Enter Answer',
          style: GoogleFonts.aBeeZee(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        16.heightBox,
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            side: BorderSide(color: colorBorder),
          ),
          child: HStack(
            [
              VStack([
                ExTextFieldNormal(
                  hint: 'Answer 1',
                  tfController: controller.answer1Controller,
                  textInputType: TextInputType.text,
                  capitalization: TextCapitalization.words,
                ),
                HStack([
                  IconButton(
                    onPressed: () {},
                    iconSize: 48,
                    icon: Icon(
                      Icons.play_circle,
                      color: colorPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 48,
                    icon: Icon(
                      Icons.pause_circle,
                      color: colorPrimary,
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => Text(
                      basename(controller.audioPath1.value),
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  24.widthBox,
                  IconButton(
                    onPressed: () => controller.goToAudioRecorder(1),
                    iconSize: 48,
                    icon: Icon(
                      Icons.mic,
                      color: colorPrimary,
                    ),
                  ),
                ]).pOnly(top: 12)
              ]).expand(),
              24.widthBox,
              ZStack([
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorBorder, width: 0.5),
                  ),
                  child: Obx(
                    () => Image.file(
                      File(controller.imagePath1.value),
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                      errorBuilder: (context, error, stackTrace) {
                        logE('$error - ${stackTrace}');
                        return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                      },
                    ).onInkTap(() => controller.goToImagePreview(controller.imagePath1.value)),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.changeImage(1),
                  iconSize: 32,
                  icon: Icon(
                    Icons.change_circle,
                    color: colorPrimary,
                  ),
                )
              ]),
            ],
            alignment: MainAxisAlignment.center,
          ).p24(),
        ),
        48.heightBox,
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            side: BorderSide(color: colorBorder),
          ),
          child: HStack(
            [
              VStack([
                ExTextFieldNormal(
                  hint: 'Answer 2',
                  tfController: controller.answer2Controller,
                  textInputType: TextInputType.text,
                  capitalization: TextCapitalization.words,
                ),
                HStack([
                  IconButton(
                    onPressed: () {},
                    iconSize: 48,
                    icon: Icon(
                      Icons.play_circle,
                      color: colorPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 48,
                    icon: Icon(
                      Icons.pause_circle,
                      color: colorPrimary,
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => Text(
                      basename(controller.audioPath2.value),
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  24.widthBox,
                  IconButton(
                    onPressed: () => controller.goToAudioRecorder(2),
                    iconSize: 48,
                    icon: Icon(
                      Icons.mic,
                      color: colorPrimary,
                    ),
                  ),
                ]).pOnly(top: 12)
              ]).expand(),
              24.widthBox,
              ZStack([
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorBorder, width: 0.5),
                  ),
                  child: Obx(
                    () => Image.file(
                      File(controller.imagePath2.value),
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                      errorBuilder: (context, error, stackTrace) {
                        logE('$error - ${stackTrace}');
                        return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                      },
                    ).onInkTap(() => controller.goToImagePreview(controller.imagePath2.value)),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.changeImage(2),
                  iconSize: 32,
                  icon: Icon(
                    Icons.change_circle,
                    color: colorPrimary,
                  ),
                )
              ]),
            ],
            alignment: MainAxisAlignment.center,
          ).p24(),
        ),
        48.heightBox,
        Visibility(
          visible: controller.currentLevel.value == 2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              side: BorderSide(color: colorBorder),
            ),
            child: HStack(
              [
                VStack([
                  ExTextFieldNormal(
                    hint: 'Answer 3',
                    tfController: controller.answer3Controller,
                    textInputType: TextInputType.text,
                    capitalization: TextCapitalization.words,
                  ),
                  HStack([
                    IconButton(
                      onPressed: () {},
                      iconSize: 48,
                      icon: Icon(
                        Icons.play_circle,
                        color: colorPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 48,
                      icon: Icon(
                        Icons.pause_circle,
                        color: colorPrimary,
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => Text(
                        basename(controller.audioPath3.value),
                        style: GoogleFonts.aBeeZee(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    24.widthBox,
                    IconButton(
                      onPressed: () => controller.goToAudioRecorder(3),
                      iconSize: 48,
                      icon: Icon(
                        Icons.mic,
                        color: colorPrimary,
                      ),
                    ),
                  ]).pOnly(top: 12)
                ]).expand(),
                24.widthBox,
                ZStack([
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorBorder, width: 0.5),
                    ),
                    child: Obx(
                      () => Image.file(
                        File(controller.imagePath3.value),
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        errorBuilder: (context, error, stackTrace) {
                          logE('$error - ${stackTrace}');
                          return Container(color: Colors.grey[300], child: Icon(Icons.image_not_supported));
                        },
                      ).onInkTap(() => controller.goToImagePreview(controller.imagePath3.value)),
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.changeImage(3),
                    iconSize: 32,
                    icon: Icon(
                      Icons.change_circle,
                      color: colorPrimary,
                    ),
                  )
                ]),
              ],
              alignment: MainAxisAlignment.center,
            ).p24(),
          ),
        ),
      ]).scrollVertical().p24(),
    );
  }
}
