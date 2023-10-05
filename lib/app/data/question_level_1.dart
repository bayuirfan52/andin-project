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
  String? _userId;
  @HiveField(6)
  bool? _isDefault;

  QuestionLevel1({
    String? id,
    String? question,
    String? imagePath1,
    String? audioPath1,
    String? answer1,
    String? userId,
    bool? isDefault,
  }) {
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
    if (userId != null) {
      this._userId = userId;
    }
    if (isDefault != null) {
      this._isDefault = isDefault;
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

  String? get userId => _userId;

  set userId(String? userId) => _userId = userId;

  bool? get isDefault => _isDefault;

  set isDefault(bool? isDefault) => _isDefault = isDefault;

  QuestionLevel1.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _question = json['question'];
    _imagePath1 = json['image_path_1'];
    _audioPath1 = json['audio_path_1'];
    _answer1 = json['answer_1'];
    _userId = json['user_id'];
    _isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['question'] = this._question;
    data['image_path_1'] = this._imagePath1;
    data['audio_path_1'] = this._audioPath1;
    data['answer_1'] = this._answer1;
    data['user_id'] = this._userId;
    data['is_default'] = this._isDefault;
    return data;
  }
}
