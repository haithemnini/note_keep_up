import '../../core.dart';

class DrawerSelect {
  static const DrawerViews defaultDrawerView = DrawerViews.home;
  static const DrawerSectionView defaultDrawerSection = DrawerSectionView.home;
  //=>

  static DrawerViews _drawerViews = defaultDrawerView;
  static DrawerViews get drawerViews => _drawerViews;
  static set selectedDrawerView(DrawerViews newDrawerViews) =>
      _drawerViews = newDrawerViews;

  //==>
  static DrawerSectionView _drawerSection = defaultDrawerSection;
  static DrawerSectionView get drawerSection => _drawerSection;
  static set selectedDrawerSection(DrawerSectionView newDrawerSectionView) =>
      _drawerSection = newDrawerSectionView;
}
