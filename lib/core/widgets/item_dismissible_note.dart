import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/domain/entities/note.dart';
import '../../features/presentation/blocs/blocs.dart';
import '../../features/presentation/pages/note/widget/item_note.dart';
import '../core.dart';

class ItemDismissibleNote extends StatelessWidget {
  const ItemDismissibleNote({
    Key? key,
    required this.itemNote,
    required this.isShowDismisse,
  }) : super(key: key);

  final Note itemNote;
  final bool isShowDismisse;

  @override
  Widget build(BuildContext context) {
    return isShowDismisse
        ? Dismissible(
            //background: Container(color: Colors.amber),
            key: ValueKey<String>(itemNote.id),
            child: ItemNote(note: itemNote),
            onDismissed: (direction) => _onDismissed(context, itemNote),
          )
        : ItemNote(note: itemNote);
  }

  void _onDismissed(BuildContext context, Note itemNote) {
    context.read<NoteBloc>().add(MoveNote(itemNote, StatusNote.archived));
  }
}
