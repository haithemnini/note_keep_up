import 'package:flutter/material.dart';
import 'package:note_app/core/core.dart';

class CommonEmptyNotes extends StatelessWidget {
  const CommonEmptyNotes(this.drawerViewNote) : super(key: null);

  final DrawerSectionView drawerViewNote;

  @override
  Widget build(BuildContext context) {
    return _switchEmptySection(context, drawerViewNote);
  }

  _switchEmptySection(BuildContext context, DrawerSectionView drawerViewNote) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunction.onRefresh(context),
          child: _emptySection(
            AppIcons.emptyNote,
            'Note you add appear here',
          ),
        );
      case DrawerSectionView.archive:
        return _emptySection(
          AppIcons.emptyArchivesNote,
          'Your archived notes appear here',
        );
      case DrawerSectionView.trash:
        return _emptySection(
          AppIcons.emptyTrashNote,
          'No Notes in Recycle Bin',
        );
    }
  }

  _emptySection(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [appIcons, const SizedBox(height: 5.0), Text(errorMsg)],
      ),
    );
  }
}
