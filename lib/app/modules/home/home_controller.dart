import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final currentStudent = Student().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getCurrentActiveStudent();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToListQuestion(int level) => Get.toNamed<dynamic>(Routes.LIST_QUESTION, arguments: level);

  Future<void> getCurrentActiveStudent() async {
    final currentStudentId = PreferenceHelper.getCurrentActiveStudent();
    logD(currentStudentId);
    await Database.getStudentData(currentStudentId ?? '').then((value) {
      currentStudent.value = value!;
    }).catchError((dynamic error) {
      logE(error.toString());
    });
  }
}
