import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class ListQuestionEditController extends GetxController {
  final currentLevel = 1.obs;
  final listLevel1 = <QuestionLevel1>[].obs;
  final listLevel2 = <QuestionLevel2>[].obs;
  final isTablet = false.obs;
  final currentStudent = Student().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLevel.value = Get.arguments as int;
    isTablet.value = PreferenceHelper.isTablet();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getCurrentActiveStudent().then((value) => handleListQuestion());
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> handleListQuestion() async {
    if (currentLevel.value == 1) {
      await getListQuestionLevel1();
    } else {
      await getListQuestionLevel2();
    }
  }

  Future<void> getCurrentActiveStudent() async {
    final currentStudentId = PreferenceHelper.getCurrentActiveStudent();
    logD(currentStudentId);
    await Database.getStudentData(currentStudentId ?? '').then((value) {
      currentStudent.value = value!;
    }).catchError((dynamic error) {
      logE(error.toString());
    });
  }


  Future<void> getListQuestionLevel1() async {
    listLevel1.clear();
    final level1 = <QuestionLevel1>[];
    await Database.getQuestionLevel1ByStudentId(studentId: currentStudent.value.id ?? '').then((value) {
      level1.addAll(value);
      listLevel1.value = level1;
    }).catchError((dynamic error) {
      logE(error);
    });
  }

  Future<void> getListQuestionLevel2() async {
    listLevel1.clear();
    final level2 = <QuestionLevel2>[];
    await Database.getQuestionLevel2ByStudentId(studentId: currentStudent.value.id ?? '').then((value) {
      level2.addAll(value);
      listLevel2.value = level2;
    }).catchError((dynamic error) {
      logE(error);
    });
  }

  void removeQuestion(String id) {
    if (currentLevel.value == 1) {
      Database.removeQuestionLevel1ById(id).then((value) {
        FlushbarHelper.showFlushbar(Get.context!, message: 'text_remove_success'.tr, type: FlushbarType.SUCCESS);
        handleListQuestion();
      }).catchError((dynamic error) {
        FlushbarHelper.showFlushbar(Get.context!, message: 'text_remove_error_'.trParams({'error': error.toString()}), type: FlushbarType.ERROR);
      });
    } else {
      Database.removeQuestionLevel2ById(id).then((value) {
        FlushbarHelper.showFlushbar(Get.context!, message: 'text_remove_success'.tr, type: FlushbarType.SUCCESS);
        handleListQuestion();
      }).catchError((dynamic error) {
        FlushbarHelper.showFlushbar(Get.context!, message: 'text_remove_error_'.trParams({'error': error.toString()}), type: FlushbarType.ERROR);
      });
    }
  }

  void goToAddQuestion() => Get.toNamed<dynamic>(Routes.ADD_QUESTION, arguments: currentLevel.value)?.then((value) => handleListQuestion());

  void goToEditQuestion(String id) => Get.toNamed<dynamic>(
        Routes.EDIT_QUESTION,
        arguments: {
          'level': currentLevel.value,
          'id': id,
        },
      )?.then((value) => handleListQuestion());
}
