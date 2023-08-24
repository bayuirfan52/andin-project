import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void goToListQuestion(int level) => Get.toNamed<dynamic>(Routes.LIST_QUESTION, arguments: level);
}
