import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../blocs/blocs.dart';

class LinearColorPicker extends StatelessWidget {
  const LinearColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      buildWhen: (previous, current) => current is ModifedColorNoteState,
      builder: (context, state) {
        int currentColor = context.read<NoteBloc>().currentColor;
        if (state is ModifedColorNoteState) {
          currentColor = state.colorIndex;
        }
        return SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...ColorNote.allColorsNote(context)
                    .asMap()
                    .entries
                    .map((entry) {
                  final int itemIndex = entry.key;
                  final Color itemColor = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: itemIndex == currentColor ? 2.0 : 0.7,
                            color: Colors.blueAccent,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: itemColor,
                          child: _getIconChild(itemIndex, currentColor),
                        ),
                      ),
                      onTap: () => _onTapColor(context, itemIndex),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onTapColor(BuildContext context, int itemIndex) =>
      context.read<NoteBloc>().add(ModifColorNote(itemIndex));

  Icon? _getIconChild(int index, int currentSelectedColor) {
    if (index == 0) {
      return currentSelectedColor == 0
          ? AppIcons.check
          : AppIcons.defuaulCheckColor;
    } else {
      return index == currentSelectedColor ? AppIcons.check : null;
    }
  }
}
