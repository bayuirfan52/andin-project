import 'dart:io';
import 'package:hive/hive.dart';

part 'answer.g.dart';

@HiveType(typeId: 3)
class Answer extends HiveObject {
  @HiveField(0)
  String? _idAnswer;
  @HiveField(1)
  String? _idStudent;
  @HiveField(2)
  String? _idQuestion;
  @HiveField(3)
  int? _level;
  @HiveField(4)
  int? _score;
  @HiveField(5)
  int? _count;

  Answer({
    String? idAnswer,
    String? idStudent,
    String? idQuestion,
    int? level,
    int? score,
    int? count,
  }) {
    if (_idAnswer != null) {
      this._idAnswer = idAnswer;
    }
    if (idStudent != null) {
      this._idStudent = idStudent;
    }
    if (idQuestion != null) {
      this._idQuestion = idQuestion;
    }
    if (level != null) {
      this._level = level;
    }
    if (score != null) {
      this._score = score;
    }
    if (count != null) {
      this._count = count;
    }
  }

  String? get idAnswer => _idAnswer;

  set idAnswer(String? idAnswer) => _idAnswer = idAnswer;

  String? get idStudent => _idStudent;

  set idStudent(String? idStudent) => _idStudent = idStudent;

  String? get idQuestion => _idQuestion;

  set idQuestion(String? idQuestion) => _idQuestion = idQuestion;

  int? get level => _level;

  set level(int? level) => _level = level;

  int? get score => _score;

  set score(int? score) => _score = score;

  int? get count => _count;

  set count(int? count) => _count = count;

  Answer.fromJson(Map<String, dynamic> json) {
    _idAnswer = json['id_answer'];
    _idStudent = json['id_student'];
    _idQuestion = json['id_question'];
    _level = json['level'];
    _score = json['score'];
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_answer'] = this._idAnswer;
    data['id_student'] = this._idStudent;
    data['id_question'] = this._idQuestion;
    data['level'] = this._level;
    data['score'] = this._score;
    data['count'] = this._count;
    return data;
  }
}
