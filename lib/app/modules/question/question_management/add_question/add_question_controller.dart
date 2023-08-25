import 'dart:io';

import 'package:andin_project/app/helper/file_helper.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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

  void goToImagePreview(String path) {
    Get.toNamed<dynamic>(Routes.IMAGE_PREVIEW, arguments: path);
  }

  Future<void> changeImage(int answerIndex) async {
    final permissionStatus = await Permission.photos.isGranted;
    logI('Permission status $permissionStatus');
    if (permissionStatus) {
      await pickImage(answerIndex);
    } else {
      await Permission.photos.request().then((value) {
        if (value.isGranted) {
          pickImage(answerIndex);
        } else {
          FlushbarHelper.showFlushbar(Get.context!, message: 'Photos Permission Needed!', type: FlushbarType.ERROR);
        }
      });
    }
  }

  Future<void> pickImage(int answerIndex) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    logI(pickedFile?.path);
    final file = await FileHelper.copyImageToAppDir(File(pickedFile?.path ?? ''));
    switch (answerIndex) {
      case 1:
        imagePath1.value = file.path;
        logI('path 1: ${imagePath1.value}');
        break;
      case 2:
        imagePath2.value = file.path;
        logI('path 2: ${imagePath2.value}');
        break;
      case 3:
        imagePath3.value = file.path;
        logI('path 3: ${imagePath3.value}');
        break;
      default:
        logE('No indexed answer selected');
        break;
    }
  }

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

  void saveQuestion() {
    if (questionController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Question title is required', type: FlushbarType.ERROR);
      return;
    }
    if (answer1Controller.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Answer 1 is required', type: FlushbarType.ERROR);
      return;
    }
    if (answer2Controller.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Answer 2 is required', type: FlushbarType.ERROR);
      return;
    }
    if (answer3Controller.text.isEmpty && currentLevel.value == 2) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Answer 3 is required', type: FlushbarType.ERROR);
      return;
    }
    if (imagePath1.value.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Image for Answer 1 is required', type: FlushbarType.ERROR);
      return;
    }
    if (imagePath2.value.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Image for Answer 2 is required', type: FlushbarType.ERROR);
      return;
    }
    if (imagePath3.value.isEmpty && currentLevel.value == 2) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Image for Answer 3 is required', type: FlushbarType.ERROR);
      return;
    }
    if (audioPath1.value.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Audio for Answer 1 is required', type: FlushbarType.ERROR);
      return;
    }
    if (audioPath2.value.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Audio for Answer 2 is required', type: FlushbarType.ERROR);
      return;
    }
    if (audioPath3.value.isEmpty && currentLevel.value == 2) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Audio for Answer 3 is required', type: FlushbarType.ERROR);
      return;
    }
  }
}
