import 'dart:io';
import 'package:hive/hive.dart';

part 'answer.g.dart';

@HiveType(typeId: 3)
class Answer extends HiveObject {
  @HiveField(0)
  String? _idStudent;
  @HiveField(1)
  String? _idQuestion;
  @HiveField(2)
  int? _level;
  @HiveField(3)
  int? _score;

  Answer({String? idStudent, String? idQuestion, int? level, int? score}) {
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
  }

  String? get idStudent => _idStudent;
  set idStudent(String? idStudent) => _idStudent = idStudent;
  String? get idQuestion => _idQuestion;
  set idQuestion(String? idQuestion) => _idQuestion = idQuestion;
  int? get level => _level;
  set level(int? level) => _level = level;
  int? get score => _score;
  set score(int? score) => _score = score;

  Answer.fromJson(Map<String, dynamic> json) {
    _idStudent = json['id_student'];
    _idQuestion = json['id_question'];
    _level = json['level'];
    _score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_student'] = this._idStudent;
    data['id_question'] = this._idQuestion;
    data['level'] = this._level;
    data['score'] = this._score;
    return data;
  }
}
