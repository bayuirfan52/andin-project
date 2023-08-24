import 'package:andin_project/app/modules/home/home_controller.dart';
import 'package:andin_project/app/modules/profile/profile_controller.dart';
import 'package:andin_project/app/modules/question/question_management/question_management_controller.dart';
import 'package:andin_project/app/modules/student/student_management/student_management_controller.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<QuestionManagementController>(() => QuestionManagementController());
    Get.lazyPut<StudentManagementController>(() => StudentManagementController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
