import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/answer.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/modules/media/audio_recorder/audio_recorder_controller.dart';
import 'package:andin_project/app/modules/question/question_detail/question_navigation.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

class QuestionDetailController extends GetxController {
  final RxString currentId = ''.obs;
  final Rx<Answer> currentAnswer = Answer().obs;
  final RxInt currentLevel = 1.obs;
  final RxInt currentScore = 0.obs;
  final Rx<QuestionLevel1> level1 = QuestionLevel1().obs;
  final Rx<QuestionLevel2> level2 = QuestionLevel2().obs;
  final RxList<QuestionLevel1> listLevel1 = <QuestionLevel1>[].obs;
  final RxList<QuestionLevel2> listLevel2 = <QuestionLevel2>[].obs;
  final Rx<Student> currentStudent = Student().obs;
  final audioPlayer = FlutterSoundPlayer();
  final Rx<Status> status = Status.IDLE.obs;
  final RxInt currentPlayedAudio = 0.obs;
  final RxString currentPlayedAnswer = ''.obs;
  final RxBool isHasPreviousQuestion = false.obs;
  final RxBool isHasNextQuestion = false.obs;
  final RxBool isAnswered = false.obs;
  final RxBool isTablet = false.obs;
  final RxBool isLoadingQuestions = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLevel.value = Get.arguments['level'] as int;
    currentId.value = Get.arguments['id'] as String;
    isTablet.value = PreferenceHelper.isTablet();
    await getCurrentActiveStudent();
    await handleListQuestion();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await init();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    await audioPlayer.closePlayer();
  }

  Future<void> init() async {
    await audioPlayer.openPlayer();
    audioPlayer.onProgress?.listen((event) {
      logI('Progress Playing: ${event.position.inSeconds}s');
    });
  }

  Future<void> play(
    String answer,
    String file,
    int index, {
    bool isDefault = false,
  }) async {
    if (status.value == Status.PAUSED) {
      await audioPlayer.resumePlayer();
    } else {
      if (isDefault) {
        final byteData = await rootBundle.load(file);
        await audioPlayer.startPlayer(
          fromDataBuffer: byteData.buffer.asUint8List(),
          whenFinished: () async {
            logI('finish');
            await stop();
          },
        );
      } else {
        await audioPlayer.startPlayer(
          fromURI: file,
          whenFinished: () async {
            logI('finish');
            await stop();
          },
        );
      }
    }
    currentPlayedAnswer.value = answer;
    currentPlayedAudio.value = index;
    status.value = Status.PLAYING;
  }

  Future<void> pause() async {
    status.value = Status.PAUSED;
    await audioPlayer.pausePlayer();
  }

  Future<void> stop() async {
    status.value = Status.IDLE;
    currentPlayedAudio.value = 0;
    currentPlayedAnswer.value = '';
    await audioPlayer.stopPlayer();
  }

  void goToSelectStudent() => Get.toNamed<dynamic>(Routes.SELECT_STUDENT);

  Future<void> previousQuestion() async {
    await _moveQuestion(-1);
  }

  Future<void> nextQuestion() async {
    if ((currentAnswer.value.score ?? 0) < 650) {
      FlushbarHelper.showFlushbar(Get.context!, title: 'text_attention'.tr, message: 'text_not_reach_minimum_score'.tr, type: FlushbarType.ERROR);
    } else {
      await _moveQuestion(1);
    }
  }

  Future<void> _moveQuestion(int offset) async {
    if (isLoadingQuestions.value) return;
    final ids = currentLevel.value == 1 ? listLevel1.map((question) => question.id).toList() : listLevel2.map((question) => question.id).toList();
    final currentQuestionId = currentLevel.value == 1 ? level1.value.id : level2.value.id;
    final nextId = questionIdAtOffset(ids, currentQuestionId, offset);
    if (nextId == null || nextId == currentId.value) return;
    currentId.value = nextId;
    await handleListQuestion();
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

  Future<void> handleListQuestion() async {
    if (isLoadingQuestions.value) return;
    isLoadingQuestions.value = true;
    try {
      if (currentLevel.value == 1) {
        await getListQuestionLevel1();
      } else {
        await getListQuestionLevel2();
      }
      await checkAnswered();
    } finally {
      isLoadingQuestions.value = false;
    }
  }

  Future<void> getListQuestionLevel1() async {
    listLevel1.clear();
    listLevel1.addAll(Database.getDefaultQuestionLevel1());
    await Database.getQuestionLevel1ByStudentId(studentId: currentStudent.value.id ?? '').then((value) {
      listLevel1.addAll(value);
      final index = listLevel1.indexWhere((element) => element.id == currentId.value);
      if (index < 0) throw StateError('Question ${currentId.value} was not found in level 1');
      level1.value = listLevel1[index];
      isHasPreviousQuestion.value = index > 0;
      isHasNextQuestion.value = index < listLevel1.length - 1;

      logD('has prev question :${isHasPreviousQuestion.value}');
      logD('has next question :${isHasNextQuestion.value}');
    }).catchError((dynamic error) {
      isHasPreviousQuestion.value = false;
      isHasNextQuestion.value = false;
      logE(error);
    });
  }

  Future<void> getListQuestionLevel2() async {
    listLevel2.clear();
    listLevel2.addAll(Database.getDefaultQuestionLevel2());
    await Database.getQuestionLevel2ByStudentId(studentId: currentStudent.value.id ?? '').then((value) {
      listLevel2.addAll(value);
      final index = listLevel2.indexWhere((element) => element.id == currentId.value);
      if (index < 0) throw StateError('Question ${currentId.value} was not found in level 2');
      level2.value = listLevel2[index];
      isHasPreviousQuestion.value = index > 0;
      isHasNextQuestion.value = index < listLevel2.length - 1;

      logD('has prev question :${isHasPreviousQuestion.value}');
      logD('has next question :${isHasNextQuestion.value}');
    }).catchError((dynamic error) {
      isHasPreviousQuestion.value = false;
      isHasNextQuestion.value = false;
      logE(error);
    });
  }

  Future<void> checkAnswered() async {
    currentScore.value = 0;
    isAnswered.value = false;
    await Database.getAnswerByStudent(currentStudent.value.id ?? '').then((value) {
      logD(value.toString());
      final questionId = currentLevel.value == 1 ? level1.value.id : level2.value.id;
      final matchingAnswers = value.where((answer) => answer.idQuestion == questionId);
      final answer = matchingAnswers.isEmpty ? null : matchingAnswers.last;
      isAnswered.value = answer != null;
      currentAnswer.value = answer ?? Answer();
      currentScore.value = answer?.score ?? 0;
      if (answer != null) {
        logD('answer_id : ${answer.idAnswer}, score: ${answer.score}, count: ${answer.count}');
      }
    });
  }

  Future<void> saveAnswer(int score) async {
    final answer = Answer();
    answer.idStudent = currentStudent.value.id;
    answer.level = currentLevel.value;

    if (currentLevel.value == 1) {
      answer.idQuestion = level1.value.id;
    } else {
      answer.idQuestion = level2.value.id;
    }

    if (isAnswered.value) {
      answer.idAnswer = currentAnswer.value.idAnswer;
      answer.count = (currentAnswer.value.count ?? 0) + 1;
      answer.score = (currentAnswer.value.score ?? 0) + score;
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch;
      final answerId = 'answer_$timeStamp';
      answer.idAnswer = answerId;
      answer.count = 1;
      answer.score = score;
    }

    await Database.addAnswer(answer).then((value) async {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_score_saved'.tr, type: FlushbarType.SUCCESS);
      await handleListQuestion();
    }).catchError((dynamic error) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_save_error'.trParams({'error': error.toString()}), type: FlushbarType.ERROR);
    });
  }
}
