import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:get/get.dart';

class ListQuestionEditController extends GetxController {
  final currentLevel = 1.obs;
  final listLevel1 = <QuestionLevel1>[].obs;
  final listLevel2 = <QuestionLevel2>[].obs;

  @override
  void onInit() {
    super.onInit();
    currentLevel.value = Get.arguments as int;
  }

  @override
  void onReady() {
    super.onReady();
    handleListQuestion();
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

  void goToAddQuestion() => Get.toNamed<dynamic>(Routes.ADD_QUESTION, arguments: currentLevel.value)?.then((value) => handleListQuestion());

  void goToEditQuestion() => Get.toNamed<dynamic>(Routes.EDIT_QUESTION, arguments: currentLevel.value)?.then((value) => handleListQuestion());
}
