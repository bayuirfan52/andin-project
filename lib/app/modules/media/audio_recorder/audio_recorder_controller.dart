import 'dart:async';
import 'dart:io';

import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:audio_session/audio_session.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderController extends BaseController {
  final recordedFile = ''.obs;
  final timeCount = '00:00'.obs;
  final status = Status.IDLE.obs;
  final audioRecorder = FlutterSoundRecorder();
  final audioPlayer = FlutterSoundPlayer();
  final maxDuration = 1.0.obs;
  final currentDuration = 0.0.obs;
  final isPlayerMode = false.obs;
  final isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = await DeviceUtil.isTablet();
    if (Get.arguments != null) {
      isPlayerMode.value = true;
      recordedFile.value = Get.arguments as String;
    }
    await init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    stop();
    audioRecorder.closeRecorder();
    audioPlayer.closePlayer();
  }

  String formatTime(int duration) {
    if (duration < 10) {
      return '0$duration';
    }
    return '$duration';
  }

  Future<void> play() async {
    if (status.value == Status.PAUSED) {
      await audioPlayer.resumePlayer();
    } else {
      await audioPlayer.startPlayer(
        fromURI: recordedFile.value,
        whenFinished: () {
          logI('finish');
          stop();
        },
      );
    }
    status.value = Status.PLAYING;
  }

  Future<void> pause() async {
    status.value = Status.PAUSED;
    await audioPlayer.pausePlayer();
  }

  Future<void> stop() async {
    status.value = Status.IDLE;
    await audioPlayer.stopPlayer();
    timeCount.value = '00:00';
  }

  Future<void> seekTo(double value) async {
    logI('Max duration: ${maxDuration.value}, current val: $value');
    final seekTo = maxDuration.value * value;
    await audioPlayer.seekToPlayer(Duration(seconds: seekTo.toInt()));
  }

  Future<void> removeFile() async {
    Get.back<dynamic>();
    final file = File(recordedFile.value);
    try {
      await file.delete();
    } catch (e) {
      logW(e.toString());
    }
    recordedFile.value = '';
    status.value = Status.IDLE;
    timeCount.value = '00:00';
  }

  Future<void> startRecord() async {
    final permissionMicrophone = await Permission.microphone.isGranted;
    final permissionMedia = await Permission.audio.isGranted;
    final permissionStorage = await Permission.storage.isGranted;
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (permissionMicrophone && (permissionMedia || permissionStorage)) {
      Directory? dir;
      if (Platform.isAndroid) {
        dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
      final audioDir = Directory('${dir?.path}/audio');
      if (!audioDir.existsSync()) {
        await audioDir.create();
      }
      final file = File(
        '${audioDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.wav',
      );
      await file.create();
      logI('File path: ${file.path}');

      status.value = Status.RECORDING;
      await audioRecorder.startRecorder(
        toFile: file.path,
      );
      recordedFile.value = file.path;
    } else {
      await Permission.microphone.request().then(
        (value) {
          if (value.isGranted && androidInfo.version.sdkInt >= 33) {
            Permission.audio.request().then((value) {
              if (value.isGranted) {
                startRecord();
              } else {
                FlushbarHelper.showFlushbar(Get.context!, message: 'Access Media Audio permission required!', type: FlushbarType.ERROR);
              }
            });
          } else if (value.isGranted && androidInfo.version.sdkInt < 33) {
            Permission.storage.request().then((value) {
              if (value.isGranted) {
                startRecord();
              } else {
                FlushbarHelper.showFlushbar(Get.context!, message: 'Access Storage permission required!', type: FlushbarType.ERROR);
              }
            });
          } else {
            FlushbarHelper.showFlushbar(Get.context!, message: 'Access Microphone permission required!', type: FlushbarType.ERROR);
          }
        },
      );
    }
  }

  Future<void> stopRecord() async {
    await audioRecorder.stopRecorder().then((value) => status.value = Status.IDLE);
    timeCount.value = '00:00';
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
    await audioRecorder.openRecorder();
    await audioPlayer.openPlayer();
    await audioRecorder.setSubscriptionDuration(Duration(milliseconds: 100));
    await audioPlayer.setSubscriptionDuration(Duration(milliseconds: 100));
    audioRecorder.onProgress?.listen((event) {
      logI('Progress Recording: ${event.duration.inSeconds}s');
      timeCount.value = '${formatTime(event.duration.inMinutes)}:${formatTime(event.duration.inSeconds % 60)}';
    });
    audioPlayer.onProgress?.listen((event) {
      logI('Progress Playing: ${event.position.inSeconds}s');
      maxDuration.value = event.duration.inSeconds.toDouble();
      currentDuration.value = event.position.inSeconds.toDouble();
      timeCount.value = '${formatTime(event.position.inMinutes)}:${formatTime(event.position.inSeconds % 60)}';
    });
  }
}

enum Status { IDLE, RECORDING, PLAYING, PAUSED }
