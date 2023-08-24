// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_level_1.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionLevel1Adapter extends TypeAdapter<QuestionLevel1> {
  @override
  final int typeId = 1;

  @override
  QuestionLevel1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionLevel1()
      .._id = fields[0] as String?
      .._question = fields[1] as String?
      .._imagePath1 = fields[2] as String?
      .._audioPath1 = fields[3] as String?
      .._answer1 = fields[4] as String?
      .._imagePath2 = fields[5] as String?
      .._audioPath2 = fields[6] as String?
      .._answer2 = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, QuestionLevel1 obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._question)
      ..writeByte(2)
      ..write(obj._imagePath1)
      ..writeByte(3)
      ..write(obj._audioPath1)
      ..writeByte(4)
      ..write(obj._answer1)
      ..writeByte(5)
      ..write(obj._imagePath2)
      ..writeByte(6)
      ..write(obj._audioPath2)
      ..writeByte(7)
      ..write(obj._answer2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionLevel1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
