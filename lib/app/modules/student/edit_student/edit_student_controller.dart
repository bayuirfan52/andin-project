import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStudentController extends BaseController {
  final studentController = TextEditingController();
  final id = ''.obs;

  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments as String;
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
      FlushbarHelper.showFlushbar(Get.context!, message: "Name can't be empty", type: FlushbarType.ERROR);
      return;
    }

    final student = Student();
    student.id = id.value;
    student.studentName = studentController.text;

    await Database.addStudent(student).then((value) {
      Get.back<dynamic>(result: true);
      FlushbarHelper.showFlushbar(Get.context!, message: 'Edit student is success', type: FlushbarType.SUCCESS);
    }).catchError((dynamic error) {
      logE('Edit Student Fail: $error');
    });
  }
}
