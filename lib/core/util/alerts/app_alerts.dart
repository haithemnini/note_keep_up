import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/domain/entities/note.dart';
import '../../../features/presentation/blocs/blocs.dart';
import '../../core.dart';

@immutable
class AppAlerts {
  const AppAlerts._();

  static void _displaySnackBar(
    BuildContext context,
    String message,
    String? actionLabel,
    void Function()? onPressed,
  ) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: context.textTheme.bodyMedium),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.colorScheme.primaryContainer,
          action: onPressed != null
              ? SnackBarAction(
                  textColor: context.colorScheme.onBackground,
                  label: actionLabel!,
                  onPressed: onPressed,
                )
              : null,
        ),
      );
  }

  static void displaySnackbarMsg(BuildContext context, String message) {
    _displaySnackBar(context, message, null, null);
  }

  static void displaySnackarUndoMove(BuildContext context, String message) {
    _displaySnackBar(
      context,
      message,
      'Undo',
      () => context.read<NoteBloc>().add(UndoMoveNote()),
    );
  }

  static void displaySnackarRecycle(BuildContext context, String message) {
    _displaySnackBar(
      context,
      message,
      'Recycle',
      () {
        final noteStatusState = context.read<StatusIconsCubit>().state;

        if (noteStatusState is ReadOnlyState) {
          final currentNote = noteStatusState.currentNote;
          context
              .read<NoteBloc>()
              .add(MoveNote(currentNote, StatusNote.undefined));
        }
      },
    );
  }

  static Future<void> showAlertDeleteDialog(
    BuildContext context,
    Note note,
  ) async {
    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () {
        context.pop();
        context.pop();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text('YES'),
      onPressed: () {
        context.pop();
        context.pop();
        context.read<NoteBloc>().add(DeleteNote(note.id));
        context.read<NoteBloc>().add(RefreshNotes(DrawerSelect.drawerSection));
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: ColorNote.getColor(context, note.colorIndex),
      content: const Text('Are you sure you want to delete this Note?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
