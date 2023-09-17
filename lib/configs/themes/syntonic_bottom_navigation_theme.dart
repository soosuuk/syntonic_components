import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicBottomNavigationBarTheme {
  static BottomNavigationBarThemeData get(bool isDarkTheme) {
    return BottomNavigationBarThemeData(
      backgroundColor: isDarkTheme ? null : Colors.white,
      selectedItemColor: SyntonicColor.primary_color ,
      unselectedItemColor: isDarkTheme ? Colors.white70 : SyntonicColor.black56,
    );
  }
}