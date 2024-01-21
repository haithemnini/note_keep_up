// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../core.dart';

class CommonLoadingNotes extends StatelessWidget {
  const CommonLoadingNotes(
    this.noteSection,
  ) : super(key: null);

  final DrawerSectionView noteSection;

  @override
  Widget build(BuildContext context) {
    return switchLoadingViewNotesSection(context, noteSection);
  }

  Widget switchLoadingViewNotesSection(
    BuildContext context,
    DrawerSectionView drawerViewNote,
  ) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunction.onRefresh(context),
          child: const CircularProgressIndicator(),
        );
      case DrawerSectionView.archive:
        return const Center(child: CircularProgressIndicator());
      case DrawerSectionView.trash:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
