// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../features/domain/entities/note.dart';

class ItemNoteCard extends StatelessWidget {
  final Note note;

  const ItemNoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            note.title.length <= 80
                ? note.title
                : '${note.title.substring(0, 80)} ...',
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(
          note.content.length <= 180
              ? note.content
              : '${note.content.substring(0, 180)} ...',
        ),
        //leading: Text(itemNote.id.toString()),
      ),
    );
  }
}
