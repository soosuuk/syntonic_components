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
      labelPadding: EdgeInsets.only(top: 16, bottom: 0),
        unselectedLabelStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(fontSize: 18),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            // letterSpacing: 0.6,
            color: colorScheme.primary ?? SyntonicColor.primary_color.toAlpha,
            height: 1.4),
        labelStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(fontSize: 18),
            fontStyle: FontStyle.italic,
            // letterSpacing: 0.6,
            fontWeight: FontWeight.w400,
            height: 1.4),
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.primary.withOpacity(0.56));
  }
}
