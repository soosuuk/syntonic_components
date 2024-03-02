import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';

import '../constants/syntonic_color.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get({required bool isDarkTheme, Color? primaryColor, required ColorScheme colorScheme}) {
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
      unselectedLabelStyle: GoogleFonts.josefinSans(
    textStyle: TextStyle(fontSize: 18),
    // fontWeight: FontWeight.w500,
    color: primaryColor ?? SyntonicColor.primary_color.toAlpha,
    height: 1.4),
        labelStyle: GoogleFonts.josefinSans(
            textStyle: TextStyle(fontSize: 18),
            // fontWeight: FontWeight.w500,
            height: 1.4),
        labelColor: colorScheme.primary,
        unselectedLabelColor:
        colorScheme.primary.withOpacity(0.72)
    );
  }
}
