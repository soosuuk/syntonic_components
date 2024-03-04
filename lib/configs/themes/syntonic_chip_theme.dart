import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';
import 'syntonic_text_theme.dart';

/// Manage all text Themes.
/// If set a value to "letterSpacing", need to convert ems(character spacing / 1000) to pt.
class SyntonicChipTheme {
  static ChipThemeData get(bool isDarkTheme) {
    return ChipThemeData(
        backgroundColor: isDarkTheme ? Colors.black87 : Colors.white70,
        disabledColor: Colors.black12,
        selectedColor: SyntonicColor.primary_color12,
        secondarySelectedColor: SyntonicColor.primary_color12,
        labelPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        padding: const EdgeInsets.all(0.0),
        shape: StadiumBorder(
            side: BorderSide(
          width: 0.0,
          color: isDarkTheme ? SyntonicColor.black56 : SyntonicColor.gainsboro,
        )),
        labelStyle: TextStyle(
          color: isDarkTheme
              ? Colors.white.withAlpha(textLabelHigh)
              : SyntonicColor.black56,
        ),
        secondaryLabelStyle: const TextStyle(color: SyntonicColor.black56),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light);
  }
}
