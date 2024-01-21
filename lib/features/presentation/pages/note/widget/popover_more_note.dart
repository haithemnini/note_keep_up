import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../../domain/entities/note.dart';
import '../../../blocs/blocs.dart';

class PopoverMoreNote extends StatelessWidget {
  final Note note;
  const PopoverMoreNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: AppIcons.trashNote,
            title: const Text('Trash'),
            onTap: () => _onTrashNote(context),
          ),
          ListTile(
            leading: AppIcons.sendNote,
            title: const Text('Send'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _onTrashNote(BuildContext context) {
    context.read<NoteBloc>().add(MoveNote(note, StatusNote.trash));
    context.pop();
  }
}
