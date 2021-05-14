// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logsmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogsModelAdapter extends TypeAdapter<LogsModel> {
  @override
  final int typeId = 0;

  @override
  LogsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogsModel(
      fields[0] as DateTime,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as dynamic,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.temprature)
      ..writeByte(3)
      ..write(obj.symptoms)
      ..writeByte(4)
      ..write(obj.addNotehere)
      ..write(obj.addMedinceLog);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
