import 'package:flutter/material.dart';

class SyntonicAppBarTheme {
  static AppBarTheme get(bool isDarkTheme) {
    return AppBarTheme(
      backgroundColor: isDarkTheme ? null : Colors.white,
      elevation: 0,
    );
  }
}