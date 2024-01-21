import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/data/datasources/local/hive/state_note_hive.dart';
import '../../../features/presentation/blocs/blocs.dart';
import '../../config/enum/enum.dart';
import '../util.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
}

extension StateGridViewIcon on GridStatus {
  IconData get icon {
    switch (this) {
      case GridStatus.singleView:
        return AppIcons.grip;
      case GridStatus.multiView:
        return AppIcons.gripVertical;
    }
  }
}

extension DrawerViewsExtensions on DrawerViews {
  String get name {
    switch (this) {
      case DrawerViews.home:
        return 'Notes';
      case DrawerViews.archive:
        return 'Archive';
      case DrawerViews.trash:
        return 'Trash';
      case DrawerViews.setting:
        return 'Setting';
    }
  }

  Icon get icon {
    switch (this) {
      case DrawerViews.home:
        return AppIcons.pen;
      case DrawerViews.archive:
        return AppIcons.archive;
      case DrawerViews.trash:
        return AppIcons.trash;
      case DrawerViews.setting:
        return AppIcons.setting;
    }
  }

  void Function(BuildContext context) get onTapItemDrawer {
    return (context) {
      if (this != DrawerViews.setting) DrawerSelect.selectedDrawerView = this;

      DrawerSelect.selectedDrawerSection = drawerSectionForView(this);
      context.read<NoteBloc>().add(RefreshNotes(DrawerSelect.drawerSection));

      final String? routerName = routerNameForView(this);
      if (routerName != null) {
        if (routerName == AppRouterName.setting.name) {
          GoRouter.of(context).pushNamed(routerName);
        } else {
          GoRouter.of(context).goNamed(routerName);
        }
      }
      Navigator.pop(context);
    };
  }

  String? routerNameForView(DrawerViews view) {
    switch (view) {
      case DrawerViews.home:
        return AppRouterName.home.name;
      case DrawerViews.archive:
        return AppRouterName.archive.name;
      case DrawerViews.trash:
        return AppRouterName.trash.name;
      case DrawerViews.setting:
        return AppRouterName.setting.name;
      default:
        return null;
    }
  }

  DrawerSectionView drawerSectionForView(DrawerViews view) {
    switch (view) {
      case DrawerViews.home:
        return DrawerSectionView.home;
      case DrawerViews.archive:
        return DrawerSectionView.archive;
      case DrawerViews.trash:
        return DrawerSectionView.trash;
      default:
        return DrawerSelect.drawerSection;
    }
  }
}

extension StatusNoteX on StatusNote {
  StateNoteHive get stateNoteHive {
    switch (this) {
      case StatusNote.undefined:
        return StateNoteHive.unspecified;
      case StatusNote.pinned:
        return StateNoteHive.pinned;
      case StatusNote.archived:
        return StateNoteHive.archived;
      case StatusNote.trash:
        return StateNoteHive.trash;
    }
  }
}

extension StatusHiveNoteX on StateNoteHive {
  StatusNote get stateNote {
    switch (this) {
      case StateNoteHive.unspecified:
        return StatusNote.undefined;
      case StateNoteHive.pinned:
        return StatusNote.pinned;
      case StateNoteHive.archived:
        return StatusNote.archived;
      case StateNoteHive.trash:
        return StatusNote.trash;
    }
  }
}
