import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentManagementController extends GetxController {
  final searchController = TextEditingController();
  final listStudent = <Student>[].obs;
  @override
  void onInit() {
    super.onInit();
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
    await Database.getAllStudentData().then((value) {
      listStudent.clear();
      listStudent.addAll(value);
    }).catchError((dynamic error) {
      logE('$error');
    });
  }

  Future<void> removeStudent(int index) async {
    final student = listStudent[index];
    if (student.id == PreferenceHelper.getCurrentActiveStudent()) {
      await PreferenceHelper.setCurrentActiveStudent(null);
    }
    await Database.removeStudentById(student.id ?? '').then((value) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'Student Removed Successfully', type: FlushbarType.SUCCESS);
      getStudentData();
    });
  }

  void goToAddStudent() => Get.toNamed<dynamic>(Routes.ADD_STUDENT);
  void goToStudentDetail() => Get.toNamed<dynamic>(Routes.STUDENT_DETAIL);
}
