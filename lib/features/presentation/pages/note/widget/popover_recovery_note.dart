import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../../domain/entities/note.dart';
import '../../../blocs/blocs.dart';

class PopoverRecoveryNote extends StatelessWidget {
  const PopoverRecoveryNote({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: AppIcons.restoreNote,
            title: const Text('Restore'),
            onTap: () => _onRestoreNote(context),
          ),
          ListTile(
            leading: AppIcons.deleteNote,
            title: const Text('Delete foverver'),
            onTap: () => AppAlerts.showAlertDeleteDialog(context, note),
          ),
        ],
      ),
    );
  }

  void _onRestoreNote(BuildContext context) {
    context.read<NoteBloc>().add(MoveNote(note, StatusNote.undefined));
    context.pop();
  }
}
