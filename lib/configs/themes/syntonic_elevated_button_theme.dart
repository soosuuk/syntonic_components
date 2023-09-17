import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicElevatedButtonTheme {
  static ElevatedButtonThemeData get(bool isDarkTheme) {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary:SyntonicColor.primary_color,
            onPrimary:isDarkTheme ? SyntonicColor.black88 : Colors.white
        ),
    );
  }


  static ButtonStyle noElevation() {
    return ElevatedButton.styleFrom(
        elevation: 0
    );
  }
}