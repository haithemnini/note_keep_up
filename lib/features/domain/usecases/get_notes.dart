import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../entities/note.dart';
import '../repositories/repositories.dart';

class GetNotesUsecase {
  final NoteRepositories noteRepositories;
  GetNotesUsecase({
    required this.noteRepositories,
  });

  Future<Either<Failure, List<Note>>> call() async {
    //  await Future.delayed(const Duration(seconds: 2));
    return await noteRepositories.getAllNotes();
  }
}
