import '../../domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.colorIndex,
    required super.modifiedTime,
    required super.stateNote,
  });
}
