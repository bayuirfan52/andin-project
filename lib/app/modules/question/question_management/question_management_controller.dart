import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:get/get.dart';

class QuestionManagementController extends GetxController {
  final isTablet = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = PreferenceHelper.isTablet();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToListQuestion(int level) => Get.toNamed<dynamic>(Routes.LIST_QUESTION_EDIT, arguments: level);
}
