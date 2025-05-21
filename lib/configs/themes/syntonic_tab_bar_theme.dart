import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get(
      {required bool isDarkTheme, required ColorScheme colorScheme}) {
    return TabBarTheme(
        dividerHeight: 1,
        dividerColor: colorScheme.outlineVariant,
        indicator: BoxDecoration(),
        labelPadding:
            const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 16),
        unselectedLabelStyle: SyntonicTextTheme.overline(),
        labelStyle:
            SyntonicTextTheme.overline().copyWith(fontWeight: FontWeight.w600),
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant);
  }
}
