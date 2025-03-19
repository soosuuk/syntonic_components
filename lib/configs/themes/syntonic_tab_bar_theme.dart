import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';

import '../constants/syntonic_color.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get(
      {required bool isDarkTheme,
      required ColorScheme colorScheme}) {
    return TabBarTheme(
      dividerHeight: 1,
        dividerColor: colorScheme.outlineVariant,
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: colorScheme.onSurface,
                  width: 2,
                  style: BorderStyle.solid
              )
          ),
        ),
      labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 16),
        unselectedLabelStyle: SyntonicTextTheme.overline(),
        labelStyle: SyntonicTextTheme.overline().copyWith(fontWeight: FontWeight.w600),
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface
    );
  }
}
