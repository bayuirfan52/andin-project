import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

class StudentManagementController extends GetxController {
  final searchController = TextEditingController();
  final RxList<Student> listStudent = <Student>[].obs;
  final RxList<Student> listStudentFiltered = <Student>[].obs;
  final RxBool isTablet = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = PreferenceHelper.isTablet();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getStudentData();
  }

  @override
  void onClose() {
    super.onClose();
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

  Future<void> removeStudent(int index) async {
    final student = listStudent[index];
    if (student.id == PreferenceHelper.getCurrentActiveStudent()) {
      await PreferenceHelper.setCurrentActiveStudent(null);
    }
    await Database.removeStudentById(student.id ?? '').then((value) async {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_student_removed'.tr, type: FlushbarType.SUCCESS);
      await getStudentData();
    });
  }

  void goToAddStudent() => Get.toNamed<dynamic>(Routes.ADD_STUDENT);
  void goToStudentDetail(String id) => Get.toNamed<dynamic>(Routes.STUDENT_DETAIL, arguments: id);
}
