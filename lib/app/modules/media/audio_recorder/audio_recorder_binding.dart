import 'package:get/get.dart';

import 'audio_recorder_controller.dart';

class AudioRecorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioRecorderController>(
      () => AudioRecorderController(),
    );
  }
}
