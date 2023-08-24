import 'dart:io';
import 'package:hive/hive.dart';

part 'question_level_1.g.dart';

@HiveType(typeId: 1)
class QuestionLevel1 extends HiveObject {
  @HiveField(0)
  String? _id;
  @HiveField(1)
  String? _question;
  @HiveField(2)
  String? _imagePath1;
  @HiveField(3)
  String? _audioPath1;
  @HiveField(4)
  String? _answer1;
  @HiveField(5)
  String? _imagePath2;
  @HiveField(6)
  String? _audioPath2;
  @HiveField(7)
  String? _answer2;

  QuestionLevel1({String? id, String? question, String? imagePath1, String? audioPath1, String? answer1, String? imagePath2, String? audioPath2, String? answer2}) {
    if (id != null) {
      this._id = id;
    }
    if (question != null) {
      this._question = question;
    }
    if (imagePath1 != null) {
      this._imagePath1 = imagePath1;
    }
    if (audioPath1 != null) {
      this._audioPath1 = audioPath1;
    }
    if (answer1 != null) {
      this._answer1 = answer1;
    }
    if (imagePath2 != null) {
      this._imagePath2 = imagePath2;
    }
    if (audioPath2 != null) {
      this._audioPath2 = audioPath2;
    }
    if (answer2 != null) {
      this._answer2 = answer2;
    }
  }

  String? get id => _id;

  set id(String? id) => _id = id;

  String? get question => _question;

  set question(String? question) => _question = question;

  String? get imagePath1 => _imagePath1;

  set imagePath1(String? imagePath1) => _imagePath1 = imagePath1;

  String? get audioPath1 => _audioPath1;

  set audioPath1(String? audioPath1) => _audioPath1 = audioPath1;

  String? get answer1 => _answer1;

  set answer1(String? answer1) => _answer1 = answer1;

  String? get imagePath2 => _imagePath2;

  set imagePath2(String? imagePath2) => _imagePath2 = imagePath2;

  String? get audioPath2 => _audioPath2;

  set audioPath2(String? audioPath2) => _audioPath2 = audioPath2;

  String? get answer2 => _answer2;

  set answer2(String? answer2) => _answer2 = answer2;

  QuestionLevel1.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _question = json['question'];
    _imagePath1 = json['image_path_1'];
    _audioPath1 = json['audio_path_1'];
    _answer1 = json['answer_1'];
    _imagePath2 = json['image_path_2'];
    _audioPath2 = json['audio_path_2'];
    _answer2 = json['answer_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['question'] = this._question;
    data['image_path_1'] = this._imagePath1;
    data['audio_path_1'] = this._audioPath1;
    data['answer_1'] = this._answer1;
    data['image_path_2'] = this._imagePath2;
    data['audio_path_2'] = this._audioPath2;
    data['answer_2'] = this._answer2;
    return data;
  }
}
