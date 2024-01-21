import 'package:flutter/material.dart';

import '../../core.dart';

abstract class ColorNote {
  ColorNote._();

  static Color getColor(BuildContext context, int colorIndex) {
    return allColorsNote(context).elementAt(colorIndex);
  }

  static List<Color> allColorsNote(BuildContext context) {
    final Brightness appBrightness = context.colorScheme.brightness;
    return appBrightness == Brightness.light
        ? [context.colorScheme.background, ..._lightColorCard]
        : [context.colorScheme.background, ..._darkColorCard];
  }

  static final List<Color> _lightColorCard = [
    const Color(0xFFFAAFA8),
    const Color(0xFFF39F76),
    const Color(0xFFFFF8B8),
    const Color(0xFFE2F6D3),
    const Color(0xFFB4DDD3),
    const Color(0xFFD4E4ED),
    const Color(0xFFAECCDC),
    const Color(0xFFD3BFDA),
    const Color(0xFFF6E2DD),
    const Color(0xFFE9E3D4),
    const Color(0xFFEFEFF1),
  ];

  static final List<Color> _darkColorCard = [
    const Color(0xFF77172E),
    const Color(0xFF692B17),
    const Color(0xFF7C4A03),
    const Color(0xFF264D3B),
    const Color(0xFF0D625D),
    const Color(0xFF256377),
    const Color(0xFF284255),
    const Color(0xFF472E5B),
    const Color(0xFF6C394F),
    const Color(0xFF4B443A),
    const Color(0xFF232427),
  ];
}
