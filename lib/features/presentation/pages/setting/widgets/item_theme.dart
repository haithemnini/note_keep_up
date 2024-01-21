import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../blocs/blocs.dart';

class ItemTheme extends StatelessWidget {
  const ItemTheme({
    super.key,
    required this.indexTheme,
  });

  final int indexTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final currentTheme = (state as LoadedTheme).themeMode;
        return RadioListTile<ThemeMode>(
          title: Text(AppThemes.values[indexTheme].title),
          value: AppThemes.values[indexTheme].mode,
          groupValue: currentTheme,
          onChanged: (_) => _onChooseTheme(context),
        );
      },
    );
  }

  void _onChooseTheme(BuildContext context) {
    context.pop();
    context.read<ThemeCubit>().themesChanged(AppThemes.values[indexTheme]);
  }
}
