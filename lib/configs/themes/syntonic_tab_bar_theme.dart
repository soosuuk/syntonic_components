import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';

import '../constants/syntonic_color.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get(
      {required bool isDarkTheme,
      required ColorScheme colorScheme}) {
    return TabBarTheme(
        // indicator: ShapeDecoration(
        //   shape: UnderlineInputBorder(
        //       borderSide: BorderSide(
        //           color: primaryColor ?? SyntonicColor.primary_color,
        //           width: 3,
        //           style: BorderStyle.solid
        //       )
        //   ),
        // ),
      labelPadding: EdgeInsets.only(top: 0, bottom: 0),
        unselectedLabelStyle: GoogleFonts.inter(
            textStyle: const TextStyle(fontSize: 14),
            fontWeight: FontWeight.w500,
            // fontStyle: FontStyle.italic,
            letterSpacing: 0.1,
            color: colorScheme.primary ?? SyntonicColor.primary_color.toAlpha,
            height: 1.4),
        labelStyle: GoogleFonts.inter(
            textStyle: const TextStyle(fontSize: 14),
            // fontStyle: FontStyle.italic,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w500,
            height: 1.4),
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.primary.withOpacity(0.72)
    );
  }
}
