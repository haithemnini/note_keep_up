import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/util.dart';
import '../../../blocs/blocs.dart';

class MoreIconNote extends StatelessWidget {
  const MoreIconNote({
    super.key,
    required this.pressMore,
    required this.pressRecovery,
  });

  final VoidCallback pressMore;
  final VoidCallback pressRecovery;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubit, StatusIconsState>(
      buildWhen: (previous, current) => current is ReadOnlyState,
      builder: (context, state) {
        final currentState =
            context.read<StatusIconsCubit>().state is ReadOnlyState;
        return IconButton(
          padding: EdgeInsets.zero,
          icon: AppIcons.more,
          onPressed: currentState ? pressRecovery : pressMore,
        );
      },
    );
  }
}
