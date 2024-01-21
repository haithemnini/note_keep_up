import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/note.dart';
import '../../blocs/blocs.dart';
import '../../../../core/core.dart';
import './widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<NoteBloc>().appScaffoldState,
      floatingActionButton: _buildFloatingActionButton(context),
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar() => AppBar(toolbarHeight: 0);

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) => _displayNotesMsg(context, state),
      builder: (context, state) {
        if (state is LoadingState) {
          return CommonLoadingNotes(state.drawerSectionView);
        } else if (state is EmptyNoteState) {
          return CommonEmptyNotes(state.drawerSectionView);
        } else if (state is ErrorState) {
          return CommonEmptyNotes(state.drawerSectionView);
        } else if (state is NotesViewState) {
          return SliverNotes(
            child: CommonNotesView(
              drawerSection: DrawerSectionView.home,
              otherNotes: state.otherNotes,
              pinnedNotes: state.pinnedNotes,
            ),
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
    } else if (state is ToggleSuccessState) {
      AppAlerts.displaySnackarUndoMove(context, state.message);
    } else if (state is EmptyInputsState) {
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: AppIcons.add,
      onPressed: () => context.read<NoteBloc>().add(const GetNoteById('')),
    );
  }
}
