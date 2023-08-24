import 'package:get/get.dart';

import 'list_question_edit_controller.dart';

class ListQuestionEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListQuestionEditController>(
      () => ListQuestionEditController(),
    );
  }
}
