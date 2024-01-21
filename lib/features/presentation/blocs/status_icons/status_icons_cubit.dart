import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/note.dart';

part 'status_icons_state.dart';

class StatusIconsCubit extends Cubit<StatusIconsState> {
  StatusIconsCubit() : super(StatusIconsInitial());

  Note _currentNote = Note.empty();
  StatusNote _currentNoteStatus = StatusNote.undefined;
  ArchiveStatus _currentArchiveStatus = ArchiveStatus.unarchive;
  final StatusNote _isTrashInNote = StatusNote.trash;

  void toggleIconsStatus(Note currentNote) {
    _currentNote = currentNote;
    _currentNoteStatus = currentNote.stateNote;
    _currentArchiveStatus = currentNote.stateNote == StatusNote.archived
        ? ArchiveStatus.archive
        : ArchiveStatus.unarchive;

    if (_isTrashInNote == _currentNoteStatus) {
      return emit(ReadOnlyState(_currentNote));
    } else {
      return emit(
        ToggleIconsStatusState(
          currentNote: _currentNote,
          currentArchiveStatus: _currentArchiveStatus,
          currentNoteStatus: _currentNoteStatus,
        ),
      );
    }
  }

  void toggleIconPinnedStatus(StatusNote currentStatus) {
    _currentNoteStatus = currentStatus == StatusNote.pinned
        ? StatusNote.undefined
        : StatusNote.pinned;
    emit(
      ToggleIconsStatusState(
        currentNote: _currentNote,
        currentNoteStatus: _currentNoteStatus,
        currentArchiveStatus: _currentArchiveStatus,
      ),
    );
  }
}
