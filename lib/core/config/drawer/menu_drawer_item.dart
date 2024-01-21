import 'package:flutter/material.dart';

import 'package:note_app/core/config/enum/drawer_views.dart';
import 'package:note_app/core/util/util.dart';

class MenuDrawerItem extends StatelessWidget {
  const MenuDrawerItem(this.drawerViews) : super(key: null);

  final DrawerViews drawerViews;

  @override
  Widget build(BuildContext context) {
    final isDrawerSelected = DrawerSelect.drawerViews == drawerViews;
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        title: Text(drawerViews.name),
        leading: drawerViews.icon,
        onTap: () => _onTapDrawer(context, isDrawerSelected),
        selected: isDrawerSelected,
        selectedColor: context.colorScheme.onPrimaryContainer,
        selectedTileColor: context.colorScheme.primary.withOpacity(0.2),
      ),
    );
  }

  void _onTapDrawer(BuildContext context, bool drawerSelected) {
    if (!drawerSelected) {
      drawerViews.onTapItemDrawer(context);
    } else {
      Navigator.pop(context);
    }
  }
}
