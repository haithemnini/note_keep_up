import 'package:dartz/dartz.dart';

import '../../model/note_model.dart';

abstract class NoteLocalDataSourse {
  Future<bool> initDb();
  Future<List<NoteModel>> getAllNote();
  Future<NoteModel> getNoteById(String noteModelById);
  Future<Unit> addNote(NoteModel noteModel);
  Future<Unit> updateNote(NoteModel noteModel);
  Future<Unit> deleteNote(String noteModelId);
}
