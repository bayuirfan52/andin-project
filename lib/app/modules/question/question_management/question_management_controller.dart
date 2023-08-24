import 'package:andin_project/app/routes/app_pages.dart';
import 'package:get/get.dart';

class QuestionManagementController extends GetxController {
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
