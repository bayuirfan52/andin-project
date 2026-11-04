import 'dart:async';
import 'dart:io';

import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderController extends BaseController {
  final RxString recordedFile = ''.obs;
  final RxString timeCount = '00:00'.obs;
  final Rx<Status> status = Status.IDLE.obs;
  final audioRecorder = FlutterSoundRecorder();
  final audioPlayer = FlutterSoundPlayer();
  final RxDouble maxDuration = 1.0.obs;
  final RxDouble currentDuration = 0.0.obs;
  final RxBool isPlayerMode = false.obs;
  final RxBool isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = PreferenceHelper.isTablet();
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
    unawaited(_disposeAudio());
  }

  Future<void> _disposeAudio() async {
    try {
      if (audioRecorder.isRecording) await audioRecorder.stopRecorder();
      if (audioPlayer.isPlaying) await audioPlayer.stopPlayer();
      await audioRecorder.closeRecorder();
      await audioPlayer.closePlayer();
    } on Exception catch (error) {
      logW('Unable to close audio resources: $error');
    }
  }

  String formatTime(int duration) {
    if (duration < 10) {
      return '0$duration';
    }
    return '$duration';
  }

  Future<void> play() async {
    if (recordedFile.value.isEmpty || !File(recordedFile.value).existsSync()) return;
    if (status.value == Status.PAUSED) {
      await audioPlayer.resumePlayer();
    } else {
      await audioPlayer.startPlayer(
        fromURI: recordedFile.value,
        whenFinished: () async {
          logI('finish');
          await stop();
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
    } on Exception catch (e) {
      logW(e.toString());
    }
    recordedFile.value = '';
    status.value = Status.IDLE;
    timeCount.value = '00:00';
  }

  Future<void> startRecord() async {
    if (status.value == Status.RECORDING) return;
    final permission = await Permission.microphone.request();
    if (!permission.isGranted) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_microphone_permission_needed'.tr, type: FlushbarType.ERROR);
      return;
    }

    File? file;
    try {
      // The recording is private app data; scoped-storage permissions are not
      // needed and requesting them can fail on newer Android versions.
      final dir = await getApplicationDocumentsDirectory();
      final audioDir = Directory('${dir.path}/audio');
      await audioDir.create(recursive: true);
      file = File('${audioDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.wav');
      await audioRecorder.startRecorder(toFile: file.path, codec: Codec.pcm16WAV);
      recordedFile.value = file.path;
      status.value = Status.RECORDING;
    } on Exception catch (error) {
      status.value = Status.IDLE;
      if (file != null && file.existsSync()) await file.delete();
      logE('Unable to start audio recording: $error');
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_recording_error'.tr, type: FlushbarType.ERROR);
    }
  }

  Future<void> stopRecord() async {
    if (status.value != Status.RECORDING) return;
    try {
      await audioRecorder.stopRecorder();
    } on Exception catch (error) {
      logE('Unable to stop audio recording: $error');
      recordedFile.value = '';
    } finally {
      status.value = Status.IDLE;
      timeCount.value = '00:00';
    }
  }

  Future<void> init() async {
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
