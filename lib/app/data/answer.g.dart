// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerAdapter extends TypeAdapter<Answer> {
  @override
  final int typeId = 3;

  @override
  Answer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answer()
      .._idStudent = fields[0] as String?
      .._idQuestion = fields[1] as String?
      .._level = fields[2] as int?
      .._score = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._idStudent)
      ..writeByte(1)
      ..write(obj._idQuestion)
      ..writeByte(2)
      ..write(obj._level)
      ..writeByte(3)
      ..write(obj._score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}