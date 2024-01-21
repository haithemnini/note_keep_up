import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/note.dart';
import '../../blocs/blocs.dart';
import './widgets/widgets.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTrash(),
      drawer: const AppDrawer(),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return BlocConsumer<NoteBloc, NoteState>(
    listener: (context, state) => _displayNotesMsg(context, state),
    builder: (context, state) {
      if (state is LoadingState) {
        return const CommonLoadingNotes(DrawerSectionView.trash);
      } else if (state is EmptyNoteState) {
        return const CommonEmptyNotes(DrawerSectionView.trash);
      } else if (state is ErrorState) {
        return CommonEmptyNotes(state.drawerSectionView);
      } else if (state is NotesViewState) {
        return CommonNotesView(
          drawerSection: DrawerSectionView.trash,
          otherNotes: state.otherNotes,
          pinnedNotes: const [],
        );
      }
      return const SizedBox.shrink();
    },
  );
}

void _displayNotesMsg(BuildContext context, NoteState state) {
  if (state is SuccessState) {
    context.read<NoteBloc>().add(RefreshNotes(DrawerSelect.drawerSection));
    AppAlerts.displaySnackbarMsg(context, state.message);
  } else if (state is GoPopNoteState) {
    context.read<NoteBloc>().add(RefreshNotes(DrawerSelect.drawerSection));
  } else if (state is GetNoteByIdState) {
    _getNoteByIdState(context, state.note);
  }
}

void _getNoteByIdState(BuildContext context, Note note) {
  context.read<StatusIconsCubit>().toggleIconsStatus(note);
  context.read<NoteBloc>().add(ModifColorNote(note.colorIndex));
  context.pushNamed(
    AppRouterName.note.name,
    pathParameters: {'noteId': note.id},
    extra: note,
  );
}
