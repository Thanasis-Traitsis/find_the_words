// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_stage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentStageAdapter extends TypeAdapter<CurrentStage> {
  @override
  final int typeId = 1;

  @override
  CurrentStage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentStage(
      answeredPositions: (fields[1] as List).cast<dynamic>(),
      answeredWords: (fields[0] as List).cast<dynamic>(),
      unavailablePositions: (fields[2] as List).cast<dynamic>(),
      key: fields[3] as String?,
      allStageWords: (fields[7] as List?)?.cast<dynamic>(),
      tableList: (fields[5] as List?)?.cast<String>(),
      wordPositions: (fields[6] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CurrentStage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.answeredWords)
      ..writeByte(1)
      ..write(obj.answeredPositions)
      ..writeByte(2)
      ..write(obj.unavailablePositions)
      ..writeByte(3)
      ..write(obj.key)
      ..writeByte(5)
      ..write(obj.tableList)
      ..writeByte(6)
      ..write(obj.wordPositions)
      ..writeByte(7)
      ..write(obj.allStageWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentStageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
