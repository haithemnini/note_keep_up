import 'package:flutter/material.dart';
import 'package:note_app/core/util/util.dart';

class TilesSection extends StatelessWidget {
  const TilesSection({super.key, required this.title, required this.tiles});

  final String title;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ...tiles
      ],
    );
  }
}
