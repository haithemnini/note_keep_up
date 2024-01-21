import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/core.dart';

import '../../features/presentation/blocs/blocs.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.hintText,
    required this.hintStyle,
    required this.textStyle,
    required this.controller,
    this.undoController,
    this.autofocus = false,
  }) : super(key: key);

  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final UndoHistoryController? undoController;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        showCursor: true,
        autofocus: autofocus,
        controller: controller,
        undoController: undoController,
        style: textStyle,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle!.copyWith(color: Colors.grey.shade400),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        onTap: () => _onTapTextField(context),
        readOnly: context.read<StatusIconsCubit>().state is ReadOnlyState,
      ),
    );
  }

  void _onTapTextField(BuildContext context) {
    if (context.read<StatusIconsCubit>().state is ReadOnlyState) {
      _showReadOnlySnackBar(context);
    }
  }

  void _showReadOnlySnackBar(BuildContext context) {
    AppAlerts.displaySnackarRecycle(context, 'Cant\'t edit Recycle Bin');
  }
}
