import 'package:flutter/material.dart';
import 'package:note_app/app/app.dart';
import 'package:note_app/app/di/get_it.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([di.init()]);
  runApp(const NoteApp());
}
