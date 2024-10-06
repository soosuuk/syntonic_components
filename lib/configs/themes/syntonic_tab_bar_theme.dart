import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';

import '../constants/syntonic_color.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get(
      {required bool isDarkTheme,
      required ColorScheme colorScheme}) {
    return TabBarTheme(
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: colorScheme.onSurface,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
        ),
      labelPadding: EdgeInsets.only(top: 0, bottom: 0),
        unselectedLabelStyle: TextStyle(fontFamily: 'social', fontWeight: FontWeight.w300, fontSize: 16, color: colorScheme.primary, letterSpacing: 1),
        labelStyle: TextStyle(fontFamily: 'social', fontWeight: FontWeight.w300, fontSize: 16, color: colorScheme.primary, letterSpacing: 1),
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant
    );
  }
}
