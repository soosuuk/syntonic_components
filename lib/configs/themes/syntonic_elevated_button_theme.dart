import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicElevatedButtonTheme {
  static ElevatedButtonThemeData get(bool isDarkTheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: isDarkTheme ? SyntonicColor.black88 : Colors.white,
          backgroundColor: SyntonicColor.primary_color),
    );
  }

  static ButtonStyle noElevation() {
    return ElevatedButton.styleFrom(elevation: 0);
  }
}
