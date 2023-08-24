import 'package:get/get.dart';

import 'list_question_controller.dart';

class ListQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListQuestionController>(
      () => ListQuestionController(),
    );
  }
}
