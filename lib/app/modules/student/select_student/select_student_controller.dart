import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectStudentController extends BaseController {
  final searchController = TextEditingController();
  final selectedIndex = 0.obs;
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
  void goToHome() => Get.toNamed<dynamic>(Routes.HOME);
}
