import 'package:andin_project/app/core/database/database.dart';
import 'package:andin_project/app/data/answer.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/modules/media/audio_recorder/audio_recorder_controller.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/device_util.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

class QuestionDetailController extends GetxController {
  final currentId = ''.obs;
  final currentAnswer = Answer().obs;
  final currentLevel = 1.obs;
  final currentScore = 0.obs;
  final level1 = QuestionLevel1().obs;
  final level2 = QuestionLevel2().obs;
  final listLevel1 = <QuestionLevel1>[].obs;
  final listLevel2 = <QuestionLevel2>[].obs;
  final currentStudent = Student().obs;
  final audioPlayer = FlutterSoundPlayer();
  final status = Status.IDLE.obs;
  final currentPlayedAudio = 0.obs;
  final currentPlayedAnswer = ''.obs;
  final isHasPreviousQuestion = false.obs;
  final isHasNextQuestion = false.obs;
  final isAnswered = false.obs;
  final isTablet = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    currentLevel.value = Get.arguments['level'] as int;
    currentId.value = Get.arguments['id'] as String;
    isTablet.value = await DeviceUtil.isTablet();
    await getCurrentActiveStudent();
    await handleListQuestion();
  }

  @override
  void onReady() {
    super.onReady();
    init();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.closePlayer();
  }

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(
      AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidWillPauseWhenDucked: true,
      ),
    );
    await audioPlayer.openPlayer();
    audioPlayer.onProgress?.listen((event) {
      logI('Progress Playing: ${event.position.inSeconds}s');
    });
  }

  Future<void> play(String answer, String file, int index) async {
    if (status.value == Status.PAUSED) {
      await audioPlayer.resumePlayer();
    } else {
      await audioPlayer.startPlayer(
        fromURI: file,
        whenFinished: () {
          logI('finish');
          stop();
        },
      );
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

  void previousQuestion() {
    if (currentLevel.value == 1) {
      final index = listLevel1.indexWhere((element) => element.id == level1.value.id);
      currentId.value = listLevel1[index - 1].id ?? '';
    } else {
      final index = listLevel2.indexWhere((element) => element.id == level2.value.id);
      currentId.value = listLevel2[index - 1].id ?? '';
    }
    handleListQuestion();
  }

  void nextQuestion() {
    if (currentLevel.value == 1) {
      final index = listLevel1.indexWhere((element) => element.id == level1.value.id);
      currentId.value = listLevel1[index + 1].id ?? '';
    } else {
      final index = listLevel2.indexWhere((element) => element.id == level2.value.id);
      currentId.value = listLevel2[index + 1].id ?? '';
    }
    handleListQuestion();
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
    if (currentLevel.value == 1) {
      await getListQuestionLevel1();
    } else {
      await getListQuestionLevel2();
    }
    await checkAnswered();
  }

  Future<void> getListQuestionLevel1() async {
    listLevel1.clear();
    await Database.getAllQuestionLevel1().then((value) {
      listLevel1.value = value;
      level1.value = listLevel1.firstWhere((element) => element.id == currentId.value);
      isHasPreviousQuestion.value = listLevel1.indexWhere((element) => element.id == level1.value.id) != 0;
      isHasNextQuestion.value = listLevel1.indexWhere((element) => element.id == level1.value.id) != listLevel1.length - 1;

      logD('has prev question :${isHasPreviousQuestion.value}');
      logD('has next question :${isHasNextQuestion.value}');
    }).catchError((dynamic error) {
      logE(error);
    });
  }

  Future<void> getListQuestionLevel2() async {
    listLevel1.clear();
    await Database.getAllQuestionLevel2().then((value) {
      listLevel2.value = value;
      level2.value = listLevel2.firstWhere((element) => element.id == currentId.value);
      isHasPreviousQuestion.value = listLevel2.indexWhere((element) => element.id == level2.value.id) != 0;
      isHasNextQuestion.value = listLevel2.indexWhere((element) => element.id == level2.value.id) != listLevel2.length - 1;

      logD('has prev question :${isHasPreviousQuestion.value}');
      logD('has next question :${isHasNextQuestion.value}');
    }).catchError((dynamic error) {
      logE(error);
    });
  }

  Future<void> checkAnswered() async {
    currentScore.value = 0;
    isAnswered.value = false;
    await Database.getAnswerByStudent(currentStudent.value.id ?? '').then((value) {
      logD(value.toString());
      value.forEach((element) {
        if (currentLevel.value == 1) {
          isAnswered.value = element.idQuestion == level1.value.id;
        } else {
          isAnswered.value = element.idQuestion == level2.value.id;
        }

        if (isAnswered.value) {
          currentScore.value = element.score ?? 0;
          currentAnswer.value = element;
          logD('answer_id : ${currentAnswer.value.idAnswer}, score: ${currentScore.value}, count: ${element.count}');
        } else {
          currentAnswer.value = Answer();
        }
      });
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

    await Database.addAnswer(answer).then((value) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_score_saved'.tr, type: FlushbarType.SUCCESS);
      handleListQuestion();
    }).catchError((dynamic error) {
      FlushbarHelper.showFlushbar(Get.context!, message: 'text_save_error'.trParams({'error': error.toString()}), type: FlushbarType.ERROR);
    });
  }
}
