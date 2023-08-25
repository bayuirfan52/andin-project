import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuestionController extends GetxController {
  final currentLevel = 1.obs;
  final imagePath1 = ''.obs;
  final imagePath2 = ''.obs;
  final imagePath3 = ''.obs;
  final audioPath1 = ''.obs;
  final audioPath2 = ''.obs;
  final audioPath3 = ''.obs;
  final questionController = TextEditingController();
  final answer1Controller = TextEditingController();
  final answer2Controller = TextEditingController();
  final answer3Controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    currentLevel.value = Get.arguments as int;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeImage() {}
  void goToAudioRecorder(int answerIndex) {
    Get.toNamed<dynamic>(Routes.AUDIO_RECORDER)?.then((value) {
      switch (answerIndex) {
        case 1:
          audioPath1.value = value as String;
          break;
        case 2:
          audioPath2.value = value as String;
          break;
        case 3:
          audioPath3.value = value as String;
          break;
        default:
          logE('No indexed answer selected');
          break;
      }
    });
  }
}
