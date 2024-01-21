import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/note.dart';
import '../../../blocs/blocs.dart';
import '../../../../../core/widgets/item_note_card.dart';
import '../../../../../../core/core.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorNote.getColor(context, note.colorIndex),
      margin: EdgeInsets.zero,
      elevation: .3,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        child: ItemNoteCard(note: note),
        onTap: () => _onTapItem(context),
      ),
    );
  }

  _onTapItem(BuildContext context) {
    context.read<NoteBloc>().add(GetNoteById(note.id));
  }
}
