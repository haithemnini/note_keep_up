import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDevice {
  static SystemUiOverlayStyle setStatusBartSilverAppBar() {
    return SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    );
    // }
  }

  // static void setNavigationBarColor(Color color) {
  //   return SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(
  //       systemNavigationBarColor: color,
  //       systemNavigationBarDividerColor: color,
  //     ),
  //   );
  // }

  static void setStatusBart(BuildContext context) {
    Brightness statusBarIconBrightness =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle().copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    );

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom],
    );

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }
}
