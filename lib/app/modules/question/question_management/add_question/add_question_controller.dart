import 'dart:io';

import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/helper/file_helper.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/modules/media/audio_recorder/audio_recorder_controller.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:audio_session/audio_session.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddQuestionController extends GetxController {
  final currentLevel = 1.obs;
  final imagePath1 = ''.obs;
  final imagePath2 = ''.obs;

  // final imagePath3 = ''.obs;
  final audioPath1 = ''.obs;
  final audioPath2 = ''.obs;

  // final audioPath3 = ''.obs;
  final isTablet = false.obs;
  final questionController = TextEditingController();
  final answer1Controller = TextEditingController();
  final answer2Controller = TextEditingController();
  final audioPlayer = FlutterSoundPlayer();
  final status = Status.IDLE.obs;
  final currentPlayedAudio = 0.obs;

  // final answer3Controller = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLevel.value = Get.arguments as int;
    isTablet.value = PreferenceHelper.isTablet();
    await init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.closePlayer();
  }

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(
      AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidWillPauseWhenDucked: true,
      ),
    );
    await audioPlayer.openPlayer();
    audioPlayer.onProgress?.listen((event) {
      logI('Progress Playing: ${event.position.inSeconds}s');
    });
  }

  Future<void> play(String file, int index) async {
    if (status.value == Status.PAUSED) {
      await audioPlayer.resumePlayer();
    } else {
      await audioPlayer.startPlayer(
        fromURI: file,
        whenFinished: () {
          logI('finish');
          stop();
        },
      );
    }
    currentPlayedAudio.value = index;
    status.value = Status.PLAYING;
  }

  Future<void> pause() async {
    status.value = Status.PAUSED;
    await audioPlayer.pausePlayer();
  }

  Future<void> stop() async {
    status.value = Status.IDLE;
    currentPlayedAudio.value = 0;
    await audioPlayer.stopPlayer();
  }

  void goToImagePreview(String path) {
    Get.toNamed<dynamic>(Routes.IMAGE_PREVIEW, arguments: path);
  }

  Future<void> changeImage(int answerIndex, ImageSource method) async {
    final imagePermissionStatus = await Permission.photos.isGranted;
    final cameraPermissionStatus = await Permission.camera.isGranted;
    final storagePermissionStatus = await Permission.storage.isGranted;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    logI('Permission status $imagePermissionStatus');

    switch (method) {
      case ImageSource.camera:
        if (cameraPermissionStatus) {
          await pickImage(answerIndex, ImageSource.camera);
        } else {
          await Permission.camera.request().then(
            (value) {
              if (value.isGranted) {
                pickImage(answerIndex, ImageSource.camera);
              } else {
                FlushbarHelper.showFlushbar(Get.context!, message: 'camera_permission_needed'.tr, type: FlushbarType.ERROR);
              }
            },
          );
        }
        break;
      case ImageSource.gallery:
        if (androidInfo.version.sdkInt >= 33) {
          if (imagePermissionStatus) {
            await pickImage(answerIndex, ImageSource.gallery);
          } else {
            await Permission.photos.request().then((value) {
              if (value.isGranted) {
                pickImage(answerIndex, ImageSource.gallery);
              } else {
                FlushbarHelper.showFlushbar(Get.context!, message: 'photo_permission_needed'.tr, type: FlushbarType.ERROR);
              }
            });
          }
        } else {
          if (storagePermissionStatus) {
            await pickImage(answerIndex, ImageSource.gallery);
          } else {
            await Permission.storage.request().then((value) {
              if (value.isGranted) {
                pickImage(answerIndex, ImageSource.gallery);
              } else {
                FlushbarHelper.showFlushbar(Get.context!, message: 'text_storage_permission_needed'.tr, type: FlushbarType.ERROR);
              }
            });
          }
        }
        break;
    }
  }

  Future<void> pickImage(int answerIndex, ImageSource method) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: method, imageQuality: 75);
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
      // case 3:
      //   imagePath3.value = file.path;
      //   logI('path 3: ${imagePath3.value}');
      //   break;
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
        // case 3:
        //   audioPath3.value = value as String;
        //   break;
        default:
          logE('No indexed answer selected');
          break;
      }
    });
  }

  Future<void> saveQuestion() async {
    if (questionController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_title_required'.tr, type: FlushbarType.ERROR);
      return;
    }
    if (answer1Controller.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_answer_required_'.trParams({'answer': 1.toString()}), type: FlushbarType.ERROR);
      return;
    }
    if (answer2Controller.text.isEmpty && currentLevel.value == 2) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_answer_required_'.trParams({'answer': 2.toString()}), type: FlushbarType.ERROR);
      return;
    }
    // if (answer3Controller.text.isEmpty && currentLevel.value == 2) {
    //   FlushbarHelper.showFlushbar(Get.context!, message: 'Answer 3 is required', type: FlushbarType.ERROR);
    //   return;
    // }
    if (imagePath1.value.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_image_required_'.trParams({'answer': 1.toString()}), type: FlushbarType.ERROR);
      return;
    }
    if (imagePath2.value.isEmpty && currentLevel.value == 2) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_image_required_'.trParams({'answer': 2.toString()}), type: FlushbarType.ERROR);
      return;
    }
    // if (imagePath3.value.isEmpty && currentLevel.value == 2) {
    //   FlushbarHelper.showFlushbar(Get.context!, message: 'Image for Answer 3 is required', type: FlushbarType.ERROR);
    //   return;
    // }
    if (audioPath1.value.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_audio_required_'.trParams({'answer': 1.toString()}), type: FlushbarType.ERROR);
      return;
    }
    if (audioPath2.value.isEmpty && currentLevel.value == 2) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_audio_required_'.trParams({'answer': 2.toString()}), type: FlushbarType.ERROR);
      return;
    }
    // if (audioPath3.value.isEmpty && currentLevel.value == 2) {
    //   FlushbarHelper.showFlushbar(Get.context!, message: 'Audio for Answer 3 is required', type: FlushbarType.ERROR);
    //   return;
    // }

    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final id = 'question_$timeStamp';
    switch (currentLevel.value) {
      case 1:
        final data = QuestionLevel1(
          id: id,
          question: questionController.text,
          answer1: answer1Controller.text,
          imagePath1: imagePath1.value,
          audioPath1: audioPath1.value,
          isDefault: false,
        );

        await Database.addQuestionLevel1(data).then((value) {
          Get.back<dynamic>();
          FlushbarHelper.showFlushbar(Get.context!, message: 'text_question_added_'.trParams({'level': 1.toString()}), type: FlushbarType.SUCCESS);
        }).catchError((dynamic error) {
          logE(error);
        });
        break;
      case 2:
        final data = QuestionLevel2(
          id: id,
          question: questionController.text,
          answer1: answer1Controller.text,
          imagePath1: imagePath1.value,
          audioPath1: audioPath1.value,
          answer2: answer2Controller.text,
          imagePath2: imagePath2.value,
          audioPath2: audioPath2.value,
          isDefault: false,
        );

        await Database.addQuestionLevel2(data).then((value) {
          Get.back<dynamic>();
          FlushbarHelper.showFlushbar(Get.context!, message: 'text_question_added_'.trParams({'level': 2.toString()}), type: FlushbarType.SUCCESS);
        }).catchError((dynamic error) {
          logE(error);
        });
        break;
    }
  }
}
