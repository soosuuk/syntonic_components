import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicDialogTheme {
  static DialogTheme get(bool isDarkTheme) {
    return DialogTheme(
      titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 1.4,
          letterSpacing: 0.3706099745449,
          color: isDarkTheme ? Colors.white : Colors.black87),
      contentTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 1.4,
          letterSpacing: 0.3706099745449,
          color: isDarkTheme ? Colors.white : SyntonicColor.black88),
    );
  }
}
