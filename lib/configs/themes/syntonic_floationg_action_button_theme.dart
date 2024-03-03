import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicFloatingActionButtonTheme {
  static FloatingActionButtonThemeData get(bool isDarkTheme) {
    return const FloatingActionButtonThemeData(
      backgroundColor: SyntonicColor.primary_color,
      foregroundColor: SyntonicColor.black88,
    );
  }

  SyntonicFloatingActionButtonTheme.secondary();
}
