import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/core.dart';

import '../../../../domain/entities/note.dart';
import '../../../blocs/blocs.dart';

class IconArchiveStatus extends StatelessWidget {
  const IconArchiveStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubit, StatusIconsState>(
      buildWhen: (previous, current) => current is ToggleIconsStatusState,
      builder: (context, state) {
        final currentNote = (state as ToggleIconsStatusState).currentNote;
        final currentNoteStatus = (state).currentNoteStatus;
        final currentArchiveStatus = (state).currentArchiveStatus;

        return IconButton(
          icon: _iconCurrentStatus(currentArchiveStatus),
          onPressed: () => _onToggleArchiveStatus(
            context: context,
            currentNote: currentNote,
            currentNoteStatus: currentNoteStatus,
          ),
        );
      },
    );
  }

  Icon _iconCurrentStatus(ArchiveStatus currentStatus) {
    return currentStatus == ArchiveStatus.archive
        ? AppIcons.archiveNote
        : AppIcons.unarchiveNote;
  }

  void _onToggleArchiveStatus({
    required BuildContext context,
    required Note currentNote,
    required StatusNote currentNoteStatus,
  }) {
    final newNoteStatus = currentNoteStatus == StatusNote.archived
        ? StatusNote.undefined
        : StatusNote.archived;

    context.read<NoteBloc>().add(MoveNote(currentNote, newNoteStatus));
  }
}
