import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../blocs/blocs.dart';

class IconPinnedStatus extends StatelessWidget {
  const IconPinnedStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubit, StatusIconsState>(
      buildWhen: (previous, current) => current is ToggleIconsStatusState,
      builder: (context, state) {
        final currentStatus =
            (state as ToggleIconsStatusState).currentNoteStatus;
        return IconButton(
          icon: Icon(iconCurrentStatus(currentStatus)),
          onPressed: () => _onTogglePinnedStatus(context, currentStatus),
        );
      },
    );
  }

  IconData iconCurrentStatus(StatusNote currentStatus) {
    return currentStatus == StatusNote.pinned ? AppIcons.pin : AppIcons.unPin;
  }

  void _onTogglePinnedStatus(BuildContext context, StatusNote currentStatus) {
    return context
        .read<StatusIconsCubit>()
        .toggleIconPinnedStatus(currentStatus);
  }
}
