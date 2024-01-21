import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../entities/note.dart';
import '../repositories/repositories.dart';

class AddNoteUsecase {
  final NoteRepositories noteRepositories;
  AddNoteUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, Unit>> call(Note note) async {
    return await noteRepositories.addNote(note);
  }
}
