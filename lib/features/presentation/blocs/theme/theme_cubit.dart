// ignore_for_file: unused_element

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeCubit({required this.sharedPreferences}) : super(ThemeInitial());

  void getCurrentThemeMode() async {
    final ThemeMode themeMode = await _getCachedThemeMode();
    emit(LoadedTheme(themeMode));
  }

  void themesChanged(AppThemes appThemes) async {
    emit(LoadedTheme(appThemes.mode));
    await _cacheThemeMode(appThemes.index);
  }

  Future<ThemeMode> _getCachedThemeMode() async {
    final int? cachedThemeModeIndex = sharedPreferences.getInt("Theme_Box");

    if (cachedThemeModeIndex != null) {
      return AppThemes.values[cachedThemeModeIndex].mode;
    } else {
      return AppThemes.values[2].mode;
    }
  }

  _cacheThemeMode(int themeModeIndex) async {
    await sharedPreferences.setInt("Theme_Box", themeModeIndex);
  }
}
