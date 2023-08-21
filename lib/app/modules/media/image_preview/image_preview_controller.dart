import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:get/get.dart';

class ImagePreviewController extends BaseController {
  final url = ''.obs;
  @override
  void onInit() {
    super.onInit();
    url.value = Get.arguments as String;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
