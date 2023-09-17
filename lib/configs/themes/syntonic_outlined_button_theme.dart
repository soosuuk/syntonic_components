import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicOutlinedButtonTheme {
  static OutlinedButtonThemeData get(bool isDarkTheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: isDarkTheme ? Colors.white : SyntonicColor.primary_color,
        side: BorderSide(color: SyntonicColor.gainsboro),
      ),
    );
  }
}