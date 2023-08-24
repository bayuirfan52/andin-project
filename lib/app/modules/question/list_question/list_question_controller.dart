import 'package:andin_project/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ListQuestionController extends GetxController {
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

  void goToQuestionDetail(String id) => Get.toNamed<dynamic>(Routes.QUESTION_DETAIL);
}
