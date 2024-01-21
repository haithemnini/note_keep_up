import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/note.dart';
import '../repositories/repositories.dart';

class GetNoteByIdUsecase {
  final NoteRepositories noteRepositories;
  GetNoteByIdUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Note>> call(String noteId) async {
    return await noteRepositories.getNoteById(noteId);
  }
}
