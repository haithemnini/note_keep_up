// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:note_app/core/core.dart';

class CommonErrorNotes extends StatelessWidget {
  final DrawerSectionView drawerViewNote;

  const CommonErrorNotes({
    Key? key,
    required this.drawerViewNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _switchErrorSection(context, drawerViewNote);
  }

  _switchErrorSection(BuildContext context, DrawerSectionView drawerViewNote) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunction.onRefresh(context),
          child: _errorSection(AppIcons.error, 'errorMsg'),
        );
      case DrawerSectionView.archive:
        return _errorSection(AppIcons.error, 'errorMsg');
      case DrawerSectionView.trash:
        return _errorSection(AppIcons.error, 'errorMsg');
    }
  }

  _errorSection(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [appIcons, const SizedBox(height: 5.0), Text(errorMsg)],
      ),
    );
  }
}
