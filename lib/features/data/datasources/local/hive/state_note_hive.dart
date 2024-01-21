import 'package:hive/hive.dart';

@HiveType(typeId: 2)
enum StateNoteHive {
  @HiveField(0)
  unspecified,

  @HiveField(1)
  pinned,

  @HiveField(2)
  archived,

  @HiveField(3)
  trash,
}

class StateNoteHiveAdapter extends TypeAdapter<StateNoteHive> {
  @override
  final int typeId = 2;

  @override
  StateNoteHive read(BinaryReader reader) {
    return StateNoteHive.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, StateNoteHive obj) {
    writer.writeByte(obj.index);
  }
}
