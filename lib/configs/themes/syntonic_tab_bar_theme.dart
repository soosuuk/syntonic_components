import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';

import '../constants/syntonic_color.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get(
      {required bool isDarkTheme,
      Color? primaryColor,
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
        unselectedLabelStyle: GoogleFonts.openSans(
            textStyle: const TextStyle(fontSize: 20),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: primaryColor ?? SyntonicColor.primary_color.toAlpha,
            height: 1.4),
        labelStyle: GoogleFonts.openSans(
            textStyle: const TextStyle(fontSize: 20),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            height: 1.4),
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.primary.withOpacity(0.72));
  }
}
