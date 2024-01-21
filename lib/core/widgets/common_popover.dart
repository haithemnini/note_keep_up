import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/presentation/blocs/blocs.dart';
import '../core.dart';

class CommonPopover extends StatelessWidget {
  final Widget child;

  const CommonPopover({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        int colorIndex = context.read<NoteBloc>().currentColor;
        if (state is ModifedColorNoteState) {
          colorIndex = state.colorIndex;
        }
        return Container(
          color: ColorNote.getColor(context, colorIndex),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandle(context),
              child,
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.08,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(2.5),
            ),
          ),
        ),
      ),
    );
  }
}
