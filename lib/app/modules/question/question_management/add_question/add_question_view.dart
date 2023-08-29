import 'dart:io';

import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/modules/media/audio_recorder/audio_recorder_controller.dart';
import 'package:andin_project/app/utils/logger.dart';
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
        title: Text('button_add_new_question'.tr),
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () => controller.saveQuestion(),
            child: Text(
              'button_save'.tr,
              textScaleFactor: 1.5,
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          )
        ],
      ),
      body: VStack([
        Text(
          'text_enter_question_title'.tr,
          style: GoogleFonts.aBeeZee(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        16.heightBox,
        ExTextFieldNormal(
          hint: 'text_question_title'.tr,
          tfController: controller.questionController,
          capitalization: TextCapitalization.words,
          textInputType: TextInputType.name,
        ),
        24.heightBox,
        Text(
          'text_enter_answer'.tr,
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
                  hint: 'text_answer_1'.tr,
                  tfController: controller.answer1Controller,
                  textInputType: TextInputType.text,
                  capitalization: TextCapitalization.words,
                ),
                HStack([
                  Obx(
                    () => Visibility(
                      visible: controller.audioPath1.isNotEmpty && (controller.status.value == Status.IDLE || controller.status.value == Status.PAUSED),
                      child: IconButton(
                        onPressed: () => controller.play(controller.audioPath1.value, 1),
                        iconSize: 48,
                        icon: Icon(
                          Icons.play_circle,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.status.value == Status.PLAYING && controller.currentPlayedAudio.value == 1,
                      child: IconButton(
                        onPressed: () => controller.pause(),
                        iconSize: 48,
                        icon: Icon(
                          Icons.pause_circle,
                          color: colorPrimary,
                        ),
                      ),
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
                    hint: 'text_answer_2'.tr,
                    tfController: controller.answer2Controller,
                    textInputType: TextInputType.text,
                    capitalization: TextCapitalization.words,
                  ),
                  HStack([
                    Obx(
                      () => Visibility(
                        visible: controller.audioPath2.isNotEmpty && (controller.status.value == Status.IDLE || controller.status.value == Status.PAUSED),
                        child: IconButton(
                          onPressed: () => controller.play(controller.audioPath2.value, 2),
                          iconSize: 48,
                          icon: Icon(
                            Icons.play_circle,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.status.value == Status.PLAYING && controller.currentPlayedAudio.value == 2,
                        child: IconButton(
                          onPressed: () => controller.pause(),
                          iconSize: 48,
                          icon: Icon(
                            Icons.pause_circle,
                            color: colorPrimary,
                          ),
                        ),
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
        ),
        48.heightBox,
        /*Visibility(
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
        ),*/
      ]).scrollVertical().p24(),
    );
  }
}
