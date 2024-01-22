import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const int textLabelHigh = 0xde; // 87%
const int textLabelMedium = 0x99; // 60%
const int textLabelDisable = 0x61; // 38%

extension Material3Palette on Color {
  Color tone(int tone) {
    assert(tone >= 0 && tone <= 100);
    final color = Hct.fromInt(value);
    final tonalPalette = TonalPalette.of(color.hue, color.chroma);
    return Color(tonalPalette.get(tone));
  }
}

/// Manage all text Themes.
/// If set a value to "letterSpacing", need to convert ems(character spacing / 1000) to pt.
class SyntonicTextTheme {
  static TextStyle headline1({required BuildContext context, Color? textColor}) {
    // return GoogleFonts.elsie(
    return GoogleFonts.playfairDisplay(
    textStyle: Theme.of(context).textTheme.displayMedium,
      fontWeight: FontWeight.w700,
        letterSpacing: 0.9,
      // color: textColor,
      // color: textColor ?? Theme.of(context).colorScheme.onSurface,
      // height: 1.4,
    );
  }

  static TextStyle headline4({required BuildContext context, Color? textColor}) {
    return GoogleFonts.playfairDisplay(
      textStyle: Theme.of(context).textTheme.headlineMedium,
      fontWeight: FontWeight.w500,
      // color: textColor,
      color: textColor ?? Theme.of(context).colorScheme.onSurface,
      height: 1.4,
    );
  }

  static TextStyle headline5({required BuildContext context, Color? textColor}) {
    return GoogleFonts.playfairDisplay(
      textStyle: Theme.of(context).textTheme.headlineSmall,
      // fontWeight: FontWeight.w300,
      color: textColor,
      height: 1.4,
    );
  }

  static TextStyle headline6({required BuildContext context, Color? textColor}) {
    return GoogleFonts.roboto(
        textStyle: Theme.of(context).textTheme.headlineSmall,
        // fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.4);
  }

  static TextStyle subtitle1({required BuildContext context, Color? textColor}) {
    return GoogleFonts.roboto(
        textStyle: Theme.of(context).textTheme.titleLarge,
        // fontWeight: FontWeight.w400,
        color: textColor ?? Theme.of(context).colorScheme.onSurface,
        height: 1.4);
  }

  static TextStyle subtitle2({required BuildContext context, Color? textColor}) {
    return GoogleFonts.robotoCondensed(
        textStyle: Theme.of(context).textTheme.titleMedium,
        fontWeight: FontWeight.w500,
        color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        height: 1.4);
  }

  static TextStyle body1({required BuildContext context, Color? textColor, bool? isLineThrough}) {
    return GoogleFonts.roboto(
      color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      textStyle: Theme.of(context).textTheme.bodyText1,
      // fontWeight: FontWeight.w400,
      height: 1.4,
      decoration: isLineThrough == true ? TextDecoration.lineThrough : null,
    );
  }

  static TextStyle body2({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.notoSerif(
        textStyle: Theme.of(context).textTheme.bodyText2,
        // color: textColor ?? (brightness == Brightness.dark
        //     ? Colors.white.withAlpha(textLabelMedium)
        //     : Colors.black.withAlpha(textLabelMedium)),
        color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 0.21519288844542);
  }

  static TextStyle caption({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.caption,
      // color: textColor ?? (brightness == Brightness.dark
      //     ? Colors.white.withAlpha(textLabelMedium)
      //     : Colors.black.withAlpha(textLabelMedium)),
      color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      height: 1.2,
      letterSpacing: 0.39452029548328,
    );
  }

  static TextStyle overline({required BuildContext context, Color? textColor}) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.labelLarge,
      // fontWeight: FontWeight.w500,
      // color: textColor ?? (brightness == Brightness.dark
      //     ? Colors.white.withAlpha(textLabelMedium)
      //     : Colors.black.withAlpha(textLabelMedium)),
      color: textColor ?? Theme.of(context).colorScheme.secondary,
      // height: 1.2,
      // letterSpacing: 1.7932740703785,
    );
  }
}
