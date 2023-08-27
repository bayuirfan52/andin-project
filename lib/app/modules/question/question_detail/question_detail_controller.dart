import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class QuestionDetailController extends GetxController {
  final currentId = ''.obs;
  final currentLevel = 1.obs;
  final level1 = QuestionLevel1().obs;
  final level2 = QuestionLevel2().obs;
  final currentStudent = Student().obs;

  @override
  void onInit() {
    super.onInit();
    currentLevel.value = Get.arguments['level'] as int;
    currentId.value = Get.arguments['id'] as String;
    getCurrentActiveStudent();
    getQuestionData(currentId.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToSelectStudent() => Get.toNamed<dynamic>(Routes.SELECT_STUDENT);

  Future<void> getCurrentActiveStudent() async {
    final currentStudentId = PreferenceHelper.getCurrentActiveStudent();
    logD(currentStudentId);
    await Database.getStudentData(currentStudentId ?? '').then((value) {
      currentStudent.value = value!;
    }).catchError((dynamic error) {
      logE(error.toString());
    });
  }

  Future<void> getQuestionData(String questionId) async {
    if (currentLevel.value == 1) {
      await Database.getQuestionLevel1(questionId).then((value) {
        if (value != null) {
          level1.value = value;
        }
      }).catchError((dynamic error) {
        logE(error);
      });
    } else {
      await Database.getQuestionLevel2(questionId).then((value) {
        if (value != null) {
          level2.value = value;
        }
      }).catchError((dynamic error) {
        logE(error);
      });
    }
  }

}
