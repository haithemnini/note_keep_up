// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteHiveAdapter extends TypeAdapter<NoteHive> {
  @override
  final int typeId = 0;

  @override
  NoteHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteHive(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      colorIndex: fields[3] as int,
      modifiedTime: fields[4] as DateTime,
      stateNoteHive: fields[5] as StateNoteHive,
    );
  }

  @override
  void write(BinaryWriter writer, NoteHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.colorIndex)
      ..writeByte(4)
      ..write(obj.modifiedTime)
      ..writeByte(5)
      ..write(obj.stateNoteHive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StateNoteAdapter extends TypeAdapter<StateNoteHive> {
  @override
  final int typeId = 2;

  @override
  StateNoteHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StateNoteHive.unspecified;
      case 1:
        return StateNoteHive.pinned;
      case 2:
        return StateNoteHive.archived;
      case 3:
        return StateNoteHive.trash;
      default:
        return StateNoteHive.unspecified;
    }
  }

  @override
  void write(BinaryWriter writer, StateNoteHive obj) {
    switch (obj) {
      case StateNoteHive.unspecified:
        writer.writeByte(0);
        break;
      case StateNoteHive.pinned:
        writer.writeByte(1);
        break;
      case StateNoteHive.archived:
        writer.writeByte(2);
        break;
      case StateNoteHive.trash:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
