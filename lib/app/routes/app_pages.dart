import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/media/audio_recorder/audio_recorder_binding.dart';
import '../modules/media/audio_recorder/audio_recorder_view.dart';
import '../modules/media/image_preview/image_preview_binding.dart';
import '../modules/media/image_preview/image_preview_view.dart';

// ignore_for_file: inference_failure_on_instance_creation

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_PREVIEW,
      page: () => const ImagePreviewView(),
      binding: ImagePreviewBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_RECORDER,
      page: () => const AudioRecorderView(),
      binding: AudioRecorderBinding(),
    ),
  ];
}
