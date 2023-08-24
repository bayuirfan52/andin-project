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
}
