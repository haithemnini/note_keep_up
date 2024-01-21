import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class TextFieldsForm extends StatelessWidget {
  final TextEditingController controllerTitle;
  final TextEditingController controllerContent;
  final UndoHistoryController undoController;
  final bool autofocus;

  const TextFieldsForm({
    super.key,
    required this.controllerTitle,
    required this.controllerContent,
    required this.undoController,
    required this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          hintText: 'Title',
          controller: controllerTitle,
          hintStyle: context.textTheme.headlineSmall,
          textStyle: context.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        CommonTextField(
          hintText: 'Note',
          controller: controllerContent,
          hintStyle: context.textTheme.bodyLarge,
          textStyle: context.textTheme.bodyLarge,
          undoController: undoController,
          autofocus: autofocus,
        ),
      ],
    );
  }
}
