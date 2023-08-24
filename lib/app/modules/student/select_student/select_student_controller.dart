import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectStudentController extends BaseController {
  final searchController = TextEditingController();
  final selectedIndex = 0.obs;
  final listStudent = <Student>[].obs;
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
  void goToDashboard() => Get.offAllNamed<dynamic>(Routes.DASHBOARD);

  void selectCurrentActiveStudent() {
    final student = listStudent[selectedIndex.value];
    PreferenceHelper.setCurrentActiveStudent(student.id ?? '');
    goToDashboard();
  }

  Future<void> getStudentData() async {
    await Database.getAllStudentData().then((value) {
      listStudent.clear();
      listStudent.addAll(value);
    }).catchError((dynamic error) {
      logE('$error');
    });
  }
}
