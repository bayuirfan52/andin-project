import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddStudentController extends GetxController {
  final studentController = TextEditingController();
  final isTablet = true.obs;

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

  Future<void> saveNewStudent() async {
    if (studentController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_name_field_error'.tr, type: FlushbarType.ERROR);
      return;
    }

    final student = Student();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    student.id = 'student_$timestamp';
    student.studentName = studentController.text;

    await Database.addStudent(student).then((value) {
      PreferenceHelper.setCurrentActiveStudent(student.id ?? '');
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_add_new_student_success'.tr, type: FlushbarType.SUCCESS);
      Get.offAllNamed<dynamic>(Routes.DASHBOARD);
    }).catchError((dynamic error) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_save_error'.trParams({'error': error.toString()}), type: FlushbarType.ERROR);
    });
  }
}
