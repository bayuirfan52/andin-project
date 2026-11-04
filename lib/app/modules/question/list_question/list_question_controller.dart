import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/answer.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class ListQuestionController extends GetxController {
  final RxInt currentLevel = 1.obs;
  final RxList<QuestionLevel1> listLevel1 = <QuestionLevel1>[].obs;
  final RxList<QuestionLevel2> listLevel2 = <QuestionLevel2>[].obs;
  final RxList<Answer> listAnswer = <Answer>[].obs;
  final Rx<Student> currentStudent = Student().obs;
  final RxBool isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLevel.value = Get.arguments as int;
    isTablet.value = PreferenceHelper.isTablet();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getCurrentActiveStudent().then((value) async {
      await handleListQuestion();
      await getAnswered();
    });
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
    level1.addAll(Database.getDefaultQuestionLevel1());
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
    level2.addAll(Database.getDefaultQuestionLevel2());
    await Database.getQuestionLevel2ByStudentId(studentId: currentStudent.value.id ?? '').then((value) {
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
