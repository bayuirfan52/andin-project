import 'package:andin_project/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ListQuestionEditController extends GetxController {
  final currentLevel = 1.obs;
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

  void goToAddQuestion() => Get.toNamed<dynamic>(Routes.ADD_QUESTION, arguments: currentLevel.value);
  void goToEditQuestion() => Get.toNamed<dynamic>(Routes.EDIT_QUESTION, arguments: currentLevel.value);
}
