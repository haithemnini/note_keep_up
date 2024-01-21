import 'package:flutter/material.dart';

enum AppThemes {
  light('Light', ThemeMode.light),
  dark('Dark', ThemeMode.dark),
  system('System default', ThemeMode.system);

  final String title;
  final ThemeMode mode;

  const AppThemes(this.title, this.mode);
}
