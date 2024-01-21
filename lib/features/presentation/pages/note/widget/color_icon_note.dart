import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../blocs/blocs.dart';

class ColorIconNote extends StatelessWidget {
  const ColorIconNote({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusIconsCubit, StatusIconsState>(
      buildWhen: (previous, current) => current is ReadOnlyState,
      builder: (context, state) {
        final currentState =
            context.read<StatusIconsCubit>().state is ReadOnlyState;
        return IconButton(
          padding: EdgeInsets.zero,
          icon: AppIcons.drawColor,
          onPressed: currentState ? null : press,
        );
      },
    );
  }
}
