import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStudentController extends BaseController {
  final studentController = TextEditingController();
  final id = ''.obs;
  final isTablet = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    id.value = Get.arguments as String;
    isTablet.value = PreferenceHelper.isTablet();
  }

  @override
  void onReady() {
    super.onReady();
    getStudentData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getStudentData() async {
    await Database.getStudentData(id.value).then((value) {
      if (value != null) {
        studentController.text = value.studentName ?? '';
      }
    }).catchError((dynamic error) {
      logE('Student Data Error: $error');
    });
  }

  Future<void> saveStudent() async {
    if (studentController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_name_field_error'.tr, type: FlushbarType.ERROR);
      return;
    }

    final student = Student();
    student.id = id.value;
    student.studentName = studentController.text;

    await Database.addStudent(student).then((value) {
      Get.back<dynamic>(result: true);
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_edit_student_success'.tr, type: FlushbarType.SUCCESS);
    }).catchError((dynamic error) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_save_error'.trParams({'error': error.toString()}), type: FlushbarType.ERROR);
    });
  }
}
