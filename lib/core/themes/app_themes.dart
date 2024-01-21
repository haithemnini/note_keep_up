import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:note_app/core/themes/app_scheme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light = FlexThemeData.light(
    // colorScheme: AppScheme.flexSchemeLight,
    scheme: FlexScheme.green,

    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    appBarOpacity: 0.00,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedHasBorder: false,
      fabUseShape: true,
      fabAlwaysCircular: true,
      fabRadius: 21.0,
      chipRadius: 13.0,
      cardRadius: 15.0,
      alignedDropdown: true,
      bottomNavigationBarElevation: 0.0,
      useInputDecoratorThemeInDialogs: true,
      snackBarRadius: 13,
      drawerWidth: 355.0,
      bottomSheetRadius: 20.0,
      navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),

    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.dekko().fontFamily,
  );

  static final dark = FlexThemeData.dark(
    //colorScheme: AppScheme.flexSchemeDark,
    //scheme: FlexScheme.ebonyClay,
    scheme: FlexScheme.green,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    appBarOpacity: 0.00,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedHasBorder: false,
      fabUseShape: true,
      fabAlwaysCircular: true,
      fabRadius: 21.0,
      chipRadius: 13.0,
      cardRadius: 15.0,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      drawerWidth: 355.0,
      snackBarRadius: 13,
      bottomNavigationBarElevation: 0.0,
      bottomSheetRadius: 35.0,
      navigationBarLabelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.dekko().fontFamily,
  );
}
