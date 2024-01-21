import 'package:dartz/dartz.dart';
import 'package:note_app/core/util/errors/failure.dart';

import '../../../core/util/util.dart';
import '../entities/note.dart';
import '../repositories/repositories.dart';

class UpdateNoteUsecase {
  final NoteRepositories noteRepositories;

  UpdateNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(Note note) async {
    return await noteRepositories.updateNote(note);
  }
}
