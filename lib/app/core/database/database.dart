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
    Hive.registerAdapter(StudentAdapter());
    await Hive.openBox<Student>(studentBox);
    Hive.registerAdapter(QuestionLevel1Adapter());
    await Hive.openBox<QuestionLevel1>(level1Box);
    Hive.registerAdapter(QuestionLevel2Adapter());
    await Hive.openBox<QuestionLevel2>(level2Box);
    Hive.registerAdapter(AnswerAdapter());
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

  static Future<List<QuestionLevel1>> getAllQuestionLevel1() async {
    final box = await Hive.openBox<QuestionLevel1>(level1Box);
    final listQuestion = <QuestionLevel1>[];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? QuestionLevel1();
      listQuestion.add(item);
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

  static Future<List<QuestionLevel2>> getAllQuestionLevel2() async {
    final box = await Hive.openBox<QuestionLevel2>(level2Box);
    final listQuestion = <QuestionLevel2>[];
    for (var i = 0; i < box.length; i++) {
      final item = box.getAt(i) ?? QuestionLevel2();
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
