import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/blocs/blocs.dart';

import '../../../../../core/core.dart';
import 'widgets.dart';

class ThemesItemTile extends StatelessWidget {
  const ThemesItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final currentTheme = (state as LoadedTheme).themeMode;
        final selectedTheme = AppThemes.values.firstWhere(
          (appTheme) => appTheme.mode == currentTheme,
        );
        return ListTile(
          title: const Text('Themes'),
          trailing: Text(
            selectedTheme.title,
            style: context.textTheme.bodyLarge,
          ),
          leading: AppIcons.themes,
          onTap: () => _showThemesDialog(context),
        );
      },
    );
  }

  Future<void> _showThemesDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: const Text('Choose Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              AppThemes.values.length,
              (itemThemeIndex) => ItemTheme(indexTheme: itemThemeIndex),
            ),
          ),
        );
      },
    );
  }
}
