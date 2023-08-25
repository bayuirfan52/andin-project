import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/widgets/ex_textfield_normal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
            onPressed: () => {},
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
                  Text(
                    'audio_file.wav',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
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
              Image.asset(
                'assets/images/ic_empty.jpg',
                fit: BoxFit.cover,
                width: 128,
                height: 128,
              ),
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
                  Text(
                    'audio_file.wav',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
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
              Image.asset(
                'assets/images/ic_empty.jpg',
                fit: BoxFit.cover,
                width: 128,
                height: 128,
              ),
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
                    Text(
                      'audio_file.wav',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
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
                Image.asset(
                  'assets/images/ic_empty.jpg',
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                ),
              ],
              alignment: MainAxisAlignment.center,
            ).p24(),
          ),
        ),
      ]).scrollVertical().p24(),
    );
  }
}
