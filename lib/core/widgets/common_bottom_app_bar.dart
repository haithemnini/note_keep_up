import 'package:flutter/material.dart';
import 'package:note_app/core/util/extensions/extensions.dart';

class CommonBottomAppBar extends StatelessWidget {
  final double? height;
  final Widget child;
  final bool isShowFAB;

  const CommonBottomAppBar({
    super.key,
    this.height,
    this.isShowFAB = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !isShowFAB ? MediaQuery.of(context).viewInsets : EdgeInsets.zero,
      child: BottomAppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        height: height ?? 55,
        shape: const CircularNotchedRectangle(),
        elevation: isShowFAB ? 3 : 0,
        color: !isShowFAB
            ? context.colorScheme.background.withOpacity(0)
            : context.colorScheme.background,
        child: child,
      ),
    );
  }
}
