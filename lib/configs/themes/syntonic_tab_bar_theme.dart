import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/services/navigation_service.dart';

class SyntonicTabBarTheme {
  static TabBarThemeData get(
      {required bool isDarkTheme, required ColorScheme colorScheme}) {
    return TabBarThemeData(
        dividerHeight: 1,
        dividerColor: colorScheme.outlineVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: colorScheme.onSurface),
          borderRadius: BorderRadius.zero,
          insets: EdgeInsets.only(left: 16),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding:
            const EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 0),
        unselectedLabelStyle: SyntonicTextTheme.caption(),
        labelStyle:
            SyntonicTextTheme.caption().copyWith(fontWeight: FontWeight.w600),
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface);
  }
}
