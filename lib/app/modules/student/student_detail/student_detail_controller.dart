import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class StudentDetailController extends GetxController {
  final id = ''.obs;
  final student = Student().obs;
  final level1TotalScore = 0.obs;
  final level2TotalScore = 0.obs;
  final averageLevel1 = 0.0.obs;
  final averageLevel2 = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments as String;
    getStudentData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void backToDashboard() => Get.offAllNamed<dynamic>(Routes.DASHBOARD);

  void goToEditStudent() => Get.toNamed<dynamic>(Routes.EDIT_STUDENT, arguments: id.value)?.then((value) {
        getStudentData();
      });

  Future<void> getStudentData() async {
    await Database.getStudentData(id.value).then((value) {
      if (value != null) {
        student.value = value;
      }
    }).catchError((dynamic error) {
      logE('Student Data Error: $error');
    });

    await Database.getAnswerByStudent(id.value).then((value) async {
      final allLevel1Question = await Database.getAllQuestionLevel1();
      final allLevel2Question = await Database.getAllQuestionLevel2();
      value.forEach((element) {
        if (element.level == 1) {
          level1TotalScore.value += element.score ?? 0;
        } else {
          level2TotalScore.value += element.score ?? 0;
        }
      });

      final avg1 = (level1TotalScore.value / allLevel1Question.length).roundToDouble();
      final avg2 = (level2TotalScore.value / allLevel2Question.length).roundToDouble();
      averageLevel1.value = avg1.isNaN ? 0.0 : avg1;
      averageLevel2.value = avg2.isNaN ? 0.0 : avg2;
    }).catchError((dynamic error) {
      logE('Answer Data Error: $error');
    });
  }

  Future<void> removeStudent() async {
    await Database.removeStudentById(id.value).then((value) {
      Get.back<dynamic>();
      FlushbarHelper.showFlushbar(Get.context!, message: 'Student Removed!', type: FlushbarType.SUCCESS);
    }).catchError((dynamic error) {
      logE('Remove Student Failed: $error');
    });
  }
}
