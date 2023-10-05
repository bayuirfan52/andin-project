import 'package:andin_project/app/data/answer.dart';
import 'package:andin_project/app/data/question_level_1.dart';
import 'package:andin_project/app/data/question_level_2.dart';
import 'package:andin_project/app/data/student.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

mixin Database {
  static const studentBox = 'student';
  static const level1Box = 'level1';
  static const level2Box = 'level2';
  static const answer = 'answer';

  static Future<void> databaseInit() async {
    final dir = await getApplicationSupportDirectory();
    await Hive.initFlutter(dir.path);
    Hive
      ..registerAdapter(StudentAdapter())
      ..registerAdapter(QuestionLevel1Adapter())
      ..registerAdapter(QuestionLevel2Adapter())
      ..registerAdapter(AnswerAdapter());

    await Hive.openBox<Student>(studentBox);
    await Hive.openBox<QuestionLevel1>(level1Box);
    await Hive.openBox<QuestionLevel2>(level2Box);
    await Hive.openBox<Answer>(answer);
    logI('Database started');
  }

  static Future<List<Student>> getAllStudentData() async {
    final box = await Hive.openBox<Student>(studentBox);
    final listStudent = <Student>[];
    for (var i = box.length - 1; i >= 0; i--) {
      final item = box.getAt(i) ?? Student();
      listStudent.add(item);
    }
    await box.close();
    return listStudent;
  }

  static Future<void> addStudent(Student data) async {
    final box = await Hive.openBox<Student>(studentBox);
    await box.put(data.id, data);
    await box.close();
  }

  static Future<Student?> getStudentData(String key) async {
    final box = await Hive.openBox<Student>(studentBox);
    final student = box.get(key);
    await box.close();

    return student;
  }

  static Future<void> removeStudentById(String id) async {
    final box = await Hive.openBox<Student>(studentBox);
    await box.delete(id);
    await box.close();
  }

  static Future<void> addQuestionLevel1(QuestionLevel1 question) async {
    final box = await Hive.openBox<QuestionLevel1>(level1Box);
    await box.put(question.id, question);
    await box.close();
  }

  static List<QuestionLevel1> getDefaultQuestionLevel1() {
    final list = <QuestionLevel1>[];
    list.add(
      QuestionLevel1(
        id: '0x001',
        question: 'Kata Benda',
        answer1: 'Gelas',
        audioPath1: 'assets/audio/gelas.mp3',
        imagePath1: 'assets/images/img_gelas.jpg',
        isDefault: true,
      ),
    );
    list.add(
      QuestionLevel1(
        id: '0x002',
        question: 'Kesukaan',
        answer1: 'Boneka',
        audioPath1: 'assets/audio/boneka.mp3',
        imagePath1: 'assets/images/img_boneka.jpg',
        isDefault: true,
      ),
    );
    list.add(
      QuestionLevel1(
        id: '0x003',
        question: 'Kesukaan',
        answer1: 'Oreo',
        audioPath1: 'assets/audio/oreo.mp3',
        imagePath1: 'assets/images/img_oreo.jpg',
        isDefault: true,
      ),
    );

    return list;
  }

  static List<QuestionLevel2> getDefaultQuestionLevel2() {
    final list = <QuestionLevel2>[];
    list.add(
      QuestionLevel2(
        id: '1x001',
        question: 'Kata Benda',
        answer1: 'Piring',
        audioPath1: 'assets/audio/piring.mp3',
        imagePath1: 'assets/images/img_piring.jpg',
        answer2: 'Sendok',
        audioPath2: 'assets/audio/sendok.mp3',
        imagePath2: 'assets/images/img_sendok.jpg',
        isDefault: true,
      ),
    );
    list.add(
      QuestionLevel2(
        id: '1x002',
        question: 'Kata Kerja',
        answer1: 'Makan',
        audioPath1: 'assets/audio/makan.mp3',
        imagePath1: 'assets/images/img_makan.jpg',
        answer2: 'Minum',
        audioPath2: 'assets/audio/minum.mp3',
        imagePath2: 'assets/images/img_minum.jpg',
        isDefault: true,
      ),
    );
    list.add(
      QuestionLevel2(
        id: '1x003',
        question: 'Kesukaan',
        answer1: 'Pir Gelang',
        audioPath1: 'assets/audio/pir_gelang.mp3',
        imagePath1: 'assets/images/img_pir_gelang.jpg',
        answer2: 'Plastisin',
        audioPath2: 'assets/audio/plastisin.mp3',
        imagePath2: 'assets/images/img_plastisin.jpg',
        isDefault: true,
      ),
    );

    return list;
  }

  static Future<List<QuestionLevel1>> getQuestionLevel1ByStudentId({required String studentId}) async {
    final box = await Hive.openBox<QuestionLevel1>(level1Box);
    final listQuestion = <QuestionLevel1>[];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? QuestionLevel1();
      if (item.userId == studentId) listQuestion.add(item);
    }
    await box.close();
    return listQuestion;
  }

  static Future<QuestionLevel1?> getQuestionLevel1(String id) async {
    final box = await Hive.openBox<QuestionLevel1>(level1Box);
    final question = box.get(id);
    await box.close();
    return question;
  }

  static Future<void> removeQuestionLevel1ById(String id) async {
    final box = await Hive.openBox<QuestionLevel1>(level1Box);
    await box.delete(id);
    await box.close();
  }

  static Future<void> addQuestionLevel2(QuestionLevel2 question) async {
    final box = await Hive.openBox<QuestionLevel2>(level2Box);
    await box.put(question.id, question);
    await box.close();
  }

  static Future<List<QuestionLevel2>> getQuestionLevel2ByStudentId({required String studentId}) async {
    final box = await Hive.openBox<QuestionLevel2>(level2Box);
    final listQuestion = <QuestionLevel2>[];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? QuestionLevel2();
      if (item.userId == studentId) listQuestion.add(item);
      listQuestion.add(item);
    }
    await box.close();
    return listQuestion;
  }

  static Future<QuestionLevel2?> getQuestionLevel2(String id) async {
    final box = await Hive.openBox<QuestionLevel2>(level2Box);
    final question = box.get(id);
    await box.close();
    return question;
  }

  static Future<void> removeQuestionLevel2ById(String id) async {
    final box = await Hive.openBox<QuestionLevel2>(level2Box);
    await box.delete(id);
    await box.close();
  }

  static Future<void> addAnswer(Answer ans) async {
    final box = await Hive.openBox<Answer>(answer);
    await box.put(ans.idAnswer, ans);
    await box.close();
  }

  static Future<List<Answer>> getAnswerByStudent(String studentId) async {
    final box = await Hive.openBox<Answer>(answer);
    final listAnswer = <Answer>[];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? Answer();
      if (item.idStudent == studentId) {
        listAnswer.add(item);
      }
    }
    await box.close();
    return listAnswer;
  }

  static Future<void> removeAnswerByStudent(String studentId) async {
    final box = await Hive.openBox<Answer>(answer);
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? Answer();
      if (item.idStudent == studentId) {
        await box.deleteAt(i);
      }
    }
    await box.close();
  }

  static Future<void> removeAnswerByQuestion(String questionId) async {
    final box = await Hive.openBox<Answer>(answer);
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? Answer();
      if (item.idQuestion == questionId) {
        await box.deleteAt(i);
      }
    }
    await box.close();
  }
}
