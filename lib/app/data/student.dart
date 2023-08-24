import 'dart:io';
import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? studentName;

  Student({this.id, this.studentName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentName = json['student_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_name'] = this.studentName;
    return data;
  }
}
