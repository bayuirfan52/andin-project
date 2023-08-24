import 'package:get/get.dart';

import 'question_management_controller.dart';

class QuestionManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionManagementController>(
      () => QuestionManagementController(),
    );
  }
}
