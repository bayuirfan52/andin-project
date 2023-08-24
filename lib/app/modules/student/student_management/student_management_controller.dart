import 'package:andin_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentManagementController extends GetxController {
  final searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToAddStudent() => Get.toNamed<dynamic>(Routes.ADD_STUDENT);
  void goToStudentDetail() => Get.toNamed<dynamic>(Routes.STUDENT_DETAIL);
}
