import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/local/note_local_data_source.dart';
import '../model/note_model.dart';

class NoteRepositoriesImpl implements NoteRepositories {
  final NoteLocalDataSourse noteLocalDataSourse;

  NoteRepositoriesImpl({
    required this.noteLocalDataSourse,
  });

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final response = await noteLocalDataSourse.getAllNote();
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> getNoteById(String noteId) async {
    try {
      final response = await noteLocalDataSourse.getNoteById(noteId);
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    try {
      if (note.title.isEmpty && note.content.isEmpty) {
        return Left(EmpytInputFailure());
      } else {
        final NoteModel convertToNoteModel = NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          colorIndex: note.colorIndex,
          modifiedTime: note.modifiedTime,
          stateNote: note.stateNote,
        );
        await noteLocalDataSourse.addNote(convertToNoteModel);
        return const Right(unit);
      }
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    try {
      final NoteModel convertToNoteModel = NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        colorIndex: note.colorIndex,
        modifiedTime: note.modifiedTime,
        stateNote: note.stateNote,
      );
      await noteLocalDataSourse.updateNote(convertToNoteModel);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(String noteId) async {
    try {
      await noteLocalDataSourse.deleteNote(noteId);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  // Future<Either<Failure, T>> executeAndHandleError<T>(
  //   Future<T> Function() function,
  // ) async {
  //   try {
  //     final result = await function();
  //     return Right(result);
  //   } on NoDataException {
  //     return Left(NoDataFailure());
  //   }
  // }
}
