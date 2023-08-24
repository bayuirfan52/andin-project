import 'package:get/get.dart';

import 'edit_student_controller.dart';

class EditStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditStudentController>(
      () => EditStudentController(),
    );
  }
}
