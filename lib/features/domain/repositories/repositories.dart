import 'package:dartz/dartz.dart';
import 'package:note_app/core/util/errors/failure.dart';

import '../entities/note.dart';

abstract class NoteRepositories {
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, Note>> getNoteById(String noteId);
  Future<Either<Failure, Unit>> addNote(Note note);
  Future<Either<Failure, Unit>> updateNote(Note note);
  Future<Either<Failure, Unit>> deleteNote(String noteId);
}
