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
      fontWeight: FontWeight.w600,
      height: 1.02,
      letterSpacing: 0.20,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle headline3(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    Locale currentLocale = Localizations.localeOf(context);
    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 1.46,
        letterSpacing: 2.38,
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
    Locale currentLocale = Localizations.localeOf(context);

    if (currentLocale.languageCode == 'ja') {
      return GoogleFonts.notoSansJp(
        color: textColor,
        fontSize: 25,
        fontWeight: FontWeight.w400,
        height: 1.64,
        letterSpacing: 0.50,
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
  }

  static TextStyle headline5(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);

    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 24,
    //     fontWeight: FontWeight.w600,
    //     height: 1,
    //     letterSpacing: 0.12,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1,
      letterSpacing: 0.12,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle headline6(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);
    //
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 21,
    //     fontWeight: FontWeight.w600,
    //     height: 1.10,
    //     letterSpacing: -0.53,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontSize: 21,
      fontWeight: FontWeight.w600,
      height: 1.10,
      letterSpacing: -0.53,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle subtitle1(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);
    //
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w600,
    //     height: 1.50,
    //     letterSpacing: 0.08,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.50,
      letterSpacing: 0.08,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle subtitle2(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);
    //
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w600,
    //     height: 1.14,
    //     letterSpacing: 0.07,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontSize: 14,
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontWeight: FontWeight.w600,
      height: 1.14,
      letterSpacing: 0.07,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle body1(
      {required BuildContext context,
      Color? textColor,
      bool? isLineThrough,
      bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);
    //
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w400,
    //     height: 1.43,
    //     letterSpacing: 0.07,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontSize: 14,
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.07,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle body2(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);
    //
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w400,
    //     height: 1.43,
    //     letterSpacing: 0.07,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontSize: 14,
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.07,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle caption(
      {required BuildContext context, Color? textColor, bool isLined = false}) {
    // Locale currentLocale = Localizations.localeOf(context);
    //
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 12,
    //     fontWeight: FontWeight.w400,
    //     height: 1.33,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }

  static TextStyle overline(
      {required BuildContext? context, Color? textColor, bool isLined = false}) {
    // Locale? currentLocale = context != null ? Localizations.localeOf(context) : null;
    //
    // if (currentLocale?.languageCode == 'ja') {
    //   return GoogleFonts.notoSansJp(
    //     fontSize: 10,
    //     fontWeight: FontWeight.w400,
    //     height: 1.60,
    //     color: textColor,
    //     decoration: isLined ? TextDecoration.underline : null,
    //   );
    // }

    return TextStyle(
      fontFamily: 'gt-america',
      fontFamilyFallback: [
        GoogleFonts.notoSansJp().fontFamily!,
      ],
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.60,
      color: textColor,
      decoration: isLined ? TextDecoration.underline : null,
    );
  }
}
