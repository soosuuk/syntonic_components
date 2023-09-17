import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int textLabelHigh = 0xde; // 87%
const int textLabelMedium = 0x99; // 60%
const int textLabelDisable = 0x61; // 38%

/// Manage all text Themes.
/// If set a value to "letterSpacing", need to convert ems(character spacing / 1000) to pt.
class SyntonicTextTheme {
  static TextStyle headline1({required BuildContext context, Color? textColor}) {
    return GoogleFonts.poppins(
      textStyle: Theme.of(context).textTheme.headline1,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 1.4,
    );
  }

  static TextStyle headline4({required BuildContext context, Color? textColor}) {
    return GoogleFonts.poppins(
      textStyle: Theme.of(context).textTheme.headline4,
      fontWeight: FontWeight.w300,
      color: textColor,
      height: 1.4,
    );
  }

  static TextStyle headline5({required BuildContext context, Color? textColor}) {
    return GoogleFonts.poppins(
      textStyle: Theme.of(context).textTheme.headline5,
      fontWeight: FontWeight.w400,
      color: textColor,
      height: 1.4,
    );
  }

  static TextStyle headline6({required BuildContext context, Color? textColor}) {
    return GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline6,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.4);
  }

  static TextStyle subtitle1({required BuildContext context, Color? textColor}) {
    return GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.subtitle1,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.4);
  }

  static TextStyle subtitle2({required BuildContext context, Color? textColor}) {
    return GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.subtitle1,
        color: textColor,
        height: 1.4);
  }

  static TextStyle subtitle2WithLineThrough({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.bodyText2,
        color: textColor ?? (brightness == Brightness.dark
            ? Colors.white.withAlpha(textLabelMedium)
            : Colors.black.withAlpha(textLabelMedium)),
      height: 1.4,
      letterSpacing: 0.21519288844542,
      decoration: TextDecoration.lineThrough
    );
  }

  static TextStyle body1({required BuildContext context, Color? textColor, bool? isLineThrough}) {
    return GoogleFonts.openSans(
      color: textColor,
      textStyle: Theme.of(context).textTheme.bodyText1,
      fontWeight: FontWeight.w400,
      height: 1.4,
      decoration: isLineThrough == true ? TextDecoration.lineThrough : null,
    );
  }

  static TextStyle body2({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.bodyText2,
        color: textColor ?? (brightness == Brightness.dark
            ? Colors.white.withAlpha(textLabelMedium)
            : Colors.black.withAlpha(textLabelMedium)),
        letterSpacing: 0.21519288844542);
  }

  static TextStyle caption({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.caption,
      color: textColor ?? (brightness == Brightness.dark
          ? Colors.white.withAlpha(textLabelMedium)
          : Colors.black.withAlpha(textLabelMedium)),
      height: 1.2,
      letterSpacing: 0.39452029548328,
    );
  }

  static TextStyle overline({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.overline,
      fontWeight: FontWeight.w500,
      color: textColor ?? (brightness == Brightness.dark
          ? Colors.white.withAlpha(textLabelMedium)
          : Colors.black.withAlpha(textLabelMedium)),
      height: 1.2,
      letterSpacing: 1.7932740703785,
    );
  }
}
