import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/core/core.dart';
import 'package:path_provider/path_provider.dart';

import 'note_hive.dart';
import '../note_local_data_source.dart';
import '../../../model/note_model.dart';
import 'state_note_hive.dart';

class NoteLocalDataSourceWithHiveImpl implements NoteLocalDataSourse {
  final String _boxNote = 'note_box';
  @override
  Future<bool> initDb() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      Hive.registerAdapter(NoteHiveAdapter());
      Hive.registerAdapter(StateNoteHiveAdapter());

      await Hive.openBox<NoteHive>(_boxNote);
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<NoteModel>> getAllNote() async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);

      final List<NoteModel> resultNotes = noteBox.values
          .map(
            (note) => NoteModel(
              id: note.id,
              title: note.title,
              content: note.content,
              colorIndex: note.colorIndex,
              modifiedTime: note.modifiedTime,
              stateNote: note.stateNoteHive.stateNote,
            ),
          )
          .toList();
      return resultNotes;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<NoteModel> getNoteById(String noteModelById) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);

      final NoteHive resultNote = noteBox.values.firstWhere(
        (element) => element.id == noteModelById,
      );

      return NoteModel(
        id: resultNote.id,
        title: resultNote.title,
        content: resultNote.content,
        colorIndex: resultNote.colorIndex,
        modifiedTime: resultNote.modifiedTime,
        stateNote: resultNote.stateNoteHive.stateNote,
      );
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> addNote(NoteModel noteModel) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);
      final noteKey = noteModel.id;

      final NoteHive noteHive = NoteHive(
        id: noteModel.id,
        title: noteModel.title,
        content: noteModel.content,
        colorIndex: noteModel.colorIndex,
        modifiedTime: noteModel.modifiedTime,
        stateNoteHive: noteModel.stateNote.stateNoteHive,
      );
      await noteBox.put(noteKey, noteHive);
      return unit;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> updateNote(NoteModel noteModel) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);
      final indexNoteId = noteModel.id;

      final NoteHive noteHive = NoteHive(
        id: noteModel.id,
        title: noteModel.title,
        content: noteModel.content,
        colorIndex: noteModel.colorIndex,
        modifiedTime: noteModel.modifiedTime,
        stateNoteHive: noteModel.stateNote.stateNoteHive,
      );
      await noteBox.put(indexNoteId, noteHive);
      return unit;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> deleteNote(String noteModelId) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);
      await noteBox.delete(noteModelId);
      return unit;
    } catch (_) {
      throw NoDataException();
    }
  }
}
