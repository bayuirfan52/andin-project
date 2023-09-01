import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectStudentController extends BaseController {
  final searchController = TextEditingController();
  final selectedIndex = 0.obs;
  final listStudent = <Student>[].obs;
  final listStudentFiltered = <Student>[].obs;
  final isTablet = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getStudentData();
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

  void goToAddStudent() => Get.toNamed<dynamic>(Routes.ADD_STUDENT);

  void goToDashboard() => Get.offAllNamed<dynamic>(Routes.DASHBOARD);

  void selectCurrentActiveStudent() {
    final student = listStudentFiltered[selectedIndex.value];
    PreferenceHelper.setCurrentActiveStudent(student.id ?? '');
    goToDashboard();
  }

  void filter() {
    listStudentFiltered.clear();
    if (searchController.text.isNotEmpty) {
      listStudent.forEach((element) {
        if (element.studentName!.contains(searchController.text.toLowerCase())) {
          listStudentFiltered.add(element);
        }
      });
    } else {
      listStudentFiltered.addAll(listStudent);
    }
  }

  Future<void> getStudentData() async {
    await Database.getAllStudentData().then((value) {
      listStudent.clear();
      listStudentFiltered.clear();
      listStudent.addAll(value);
      listStudentFiltered.addAll(value);
    }).catchError((dynamic error) {
      logE('$error');
    });
  }
}
