import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const int textLabelHigh = 0xde; // 87%
const int textLabelMedium = 0x99; // 60%
const int textLabelDisable = 0x61; // 38%

// abrilFatface poppins quicksands, cinzel, faunaOne, rufina oxygen, spectral, bungee/openSans, caveat/josefinSans, montaguSlab/figtree,  fjallaOne/sourceSans3/yellow, marcellus/dmsans,,  tenorsans nunitoSans, nunito, inter
const TextStyle Function(
    {Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing}) typeface1 = GoogleFonts.libreCaslonText;
const TextStyle Function(
    {Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing}) typeface2 = GoogleFonts.libreCaslonText;
const TextStyle Function(
    {Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing}) typeface3 = GoogleFonts.lato;
const bool isBold = true;

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
  static TextStyle headline1(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    return GoogleFonts.workSans(
      color: textColor,
      fontSize: 40,
      fontWeight: FontWeight.w500,
      height: 1.02,
      letterSpacing: 0.20,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle headline3(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;
    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w400,
        fontSize: 32,
        color: textColor,
        height: 1.16,
        letterSpacing: -0.38,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return GoogleFonts.workSans(
      color: textColor,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.46,
      letterSpacing: 2.38,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle headline4(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w500,
        fontSize: 27,
        color: textColor,
        height: 1.07,
        letterSpacing: 0.14,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return GoogleFonts.workSans(
      color: textColor,
      fontSize: 25,
      fontWeight: FontWeight.w400,
      height: 1.64,
      letterSpacing: 0.50,
      decoration: isLined ? TextDecoration.underline : null,
    );


    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w500,
      fontSize: 27,
      color: textColor,
      height: 1.07,
      letterSpacing: 0.14,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle headline5(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w700,
        fontSize: 23,
        color: textColor,
        height: 1.26,
        letterSpacing: 0.69,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    // return GoogleFonts.workSans(
    //   fontWeight: FontWeight.w400,
    //   fontSize: 25,
    //   color: textColor,
    //   height: 1.64,
    //   letterSpacing: 0.50,
    //   decoration: isLined ? TextDecoration.underline : null,
    // );


    return GoogleFonts.workSans(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: textColor,
    height: 1.33,
    letterSpacing: 1.17,
    decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle headline6(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w700,
        fontSize: 17,
        color: textColor,
        height: 1.18,
        letterSpacing: -0.17,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return GoogleFonts.workSans(
    fontWeight: FontWeight.w300,
    fontSize: 18,
    color: textColor,
    height: 1.50,
    letterSpacing: 1.35,
    decoration: isLined ? TextDecoration.underline : null,
    );

    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: textColor,
      height: 1.18,
      letterSpacing: -0.17,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle subtitle1(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: textColor,
        height: 2.36,
        letterSpacing: 0.70,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return TextStyle(
      fontFamily: 'gt-america',
      fontSize: 17,
      color: textColor,
      height: 2.36,
      letterSpacing: -0.34,
      fontWeight: FontWeight.w600,
      decoration: isLined ? TextDecoration.underline : null,
    );


  }

  static TextStyle subtitle2(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: textColor,
        height: 1.20,
        letterSpacing: -0.15,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 1.20,
      letterSpacing: -0.30,
      decoration: isLined ? TextDecoration.underline : null,
    );

    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: textColor,
      height: 1.20,
      letterSpacing: -0.15,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle body1(
      {required BuildContext context,
      Color? textColor,
      bool? isLineThrough,
      bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: textColor,
        letterSpacing: -0.15,
        height: 1.20,
        decoration: isLined
            ? TextDecoration.underline
            : (isLineThrough == true ? TextDecoration.lineThrough : null),
      );
    }

    return GoogleFonts.workSans(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: textColor,
    height: 1.43,
    letterSpacing: 0.14,
    decoration: isLined ? TextDecoration.underline : null,
    );

    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: textColor,
      letterSpacing: -0.15,
      height: 1.20,
      decoration: isLined
          ? TextDecoration.underline
          : (isLineThrough == true ? TextDecoration.lineThrough : null),
    );
  }

  static TextStyle body2(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        height: 1.38,
        letterSpacing: 0.26,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w400,
      fontSize: 13,
      color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      height: 1.38,
      letterSpacing: 0.26,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle caption(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: textColor,
        height: 1.38,
        letterSpacing: -0.13,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w400,
      fontSize: 13,
      color: textColor ?? Theme.of(context).colorScheme.onSurface,
      height: 1.38,
      letterSpacing: -0.13,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle overline(
      {BuildContext? context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = window.locale;

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: textColor,
        height: 1.17,
        letterSpacing: 0.36,
        decoration: isLined ? TextDecoration.underline : null,
      );
    }

    return TextStyle(
      fontFamily: 'gt-america',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: textColor,
      height: 1.17,
      letterSpacing: 0.36,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }
}
