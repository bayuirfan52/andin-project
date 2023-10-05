// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_level_2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionLevel2Adapter extends TypeAdapter<QuestionLevel2> {
  @override
  final int typeId = 2;

  @override
  QuestionLevel2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionLevel2()
      .._id = fields[0] as String?
      .._question = fields[1] as String?
      .._imagePath1 = fields[2] as String?
      .._audioPath1 = fields[3] as String?
      .._answer1 = fields[4] as String?
      .._imagePath2 = fields[5] as String?
      .._audioPath2 = fields[6] as String?
      .._answer2 = fields[7] as String?
      .._userId = fields[8] as String?
      .._isDefault = fields[9] as bool?;
  }

  @override
  void write(BinaryWriter writer, QuestionLevel2 obj) {
    writer
      ..writeByte(10)
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
      ..write(obj._answer2)
      ..writeByte(8)
      ..write(obj._userId)
      ..writeByte(9)
      ..write(obj._isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionLevel2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
