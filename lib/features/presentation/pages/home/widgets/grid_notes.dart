import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../domain/entities/note.dart';
import '../../../blocs/blocs.dart';
import '../../../../../../core/core.dart';

class GridNotes extends StatelessWidget {
  final List<Note> notes;
  final bool isShowDismisse;

  const GridNotes({
    Key? key,
    required this.notes,
    this.isShowDismisse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusGridCubit, StatusGridState>(
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          sliver: _buildMasonryGrid(
            currentStatusCrossCount(
              (state as StatusGridViewState).currentStatus,
            ),
          ),
        );
      },
    );
  }

  int currentStatusCrossCount(GridStatus currentStatus) =>
      currentStatus == GridStatus.multiView ? 2 : 1;

  SliverMasonryGrid _buildMasonryGrid(int crossAxisCount) {
    return SliverMasonryGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childCount: notes.length,
      itemBuilder: (_, index) {
        final Note itemNote = notes[index];
        return ItemDismissibleNote(
          itemNote: itemNote,
          isShowDismisse: isShowDismisse,
        );
      },
    );
  }
}
