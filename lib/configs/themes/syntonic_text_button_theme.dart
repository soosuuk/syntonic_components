import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicTextButtonTheme {
  static TextButtonThemeData get(bool isDarkTheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: isDarkTheme ? SyntonicColor.primary_color : SyntonicColor.primary_color
      ),
    );
  }
}