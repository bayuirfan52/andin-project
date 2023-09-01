import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddStudentController extends GetxController {
  final studentController = TextEditingController();
  final isTablet = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = await DeviceUtil.isTablet();
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
      FlushbarHelper.showFlushbar(Get.context!, message: "Name can't be empty", type: FlushbarType.ERROR);
      return;
    }

    final student = Student();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    student.id = 'student_$timestamp';
    student.studentName = studentController.text;

    await Database.addStudent(student).then((value) {
      PreferenceHelper.setCurrentActiveStudent(student.id ?? '');
      FlushbarHelper.showFlushbar(Get.context!, message: 'Add new student is success', type: FlushbarType.SUCCESS);
      Get.offAllNamed<dynamic>(Routes.DASHBOARD);
    }).catchError((error) {});
  }
}
