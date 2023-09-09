import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/answer.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class ListQuestionController extends GetxController {
  final currentLevel = 1.obs;
  final listLevel1 = <QuestionLevel1>[].obs;
  final listLevel2 = <QuestionLevel2>[].obs;
  final listAnswer = <Answer>[].obs;
  final currentStudent = Student().obs;
  final isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLevel.value = Get.arguments as int;
    isTablet.value = await DeviceUtil.isTablet();
  }

  @override
  void onReady() {
    super.onReady();
    handleListQuestion();
    getCurrentActiveStudent().then(
      (value) => getAnswered(),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToSelectStudent() => Get.toNamed<dynamic>(Routes.SELECT_STUDENT);

  Future<void> handleListQuestion() async {
    if (currentLevel.value == 1) {
      await getListQuestionLevel1();
    } else {
      await getListQuestionLevel2();
    }
  }

  Future<void> getAnswered() async {
    await Database.getAnswerByStudent(currentStudent.value.id ?? '').then((value) {
      listAnswer.value = value;
      logI('Answer | ${value}');
    }).catchError((dynamic error) {
      logE(error);
    });
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
    await Database.getAllQuestionLevel1().then((value) {
      level1.addAll(value);
      listLevel1.value = level1;
    }).catchError((dynamic error) {
      logE(error);
    });
  }

  Future<void> getListQuestionLevel2() async {
    listLevel1.clear();
    final level2 = <QuestionLevel2>[];
    await Database.getAllQuestionLevel2().then((value) {
      level2.addAll(value);
      listLevel2.value = level2;
    }).catchError((dynamic error) {
      logE(error);
    });
  }

  void goToQuestionDetail(String id) => Get.toNamed<dynamic>(
        Routes.QUESTION_DETAIL,
        arguments: {
          'level': currentLevel.value,
          'id': id,
        },
      )?.then((value) => onReady());
}
