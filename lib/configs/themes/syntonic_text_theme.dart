import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const int textLabelHigh = 0xde; // 87%
const int textLabelMedium = 0x99; // 60%
const int textLabelDisable = 0x61; // 38%

// abrilFatface poppins quicksands, cinzel, faunaOne, rufina oxygen, spectral, bungee/openSans, caveat/josefinSans, montaguSlab/figtree,  fjallaOne/sourceSans3/yellow, marcellus/dmsans,,  tenorsans nunitoSans, nunito, inter
const TextStyle Function({Paint? background, Color? backgroundColor, Color? color, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, List<FontFeature>? fontFeatures, double? fontSize, FontStyle? fontStyle, FontWeight? fontWeight, Paint? foreground, double? height, double? letterSpacing, Locale? locale, List<Shadow>? shadows, TextBaseline? textBaseline, TextStyle? textStyle, double? wordSpacing}) typeface1 = GoogleFonts.libreCaslonText;
const TextStyle Function({Paint? background, Color? backgroundColor, Color? color, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, List<FontFeature>? fontFeatures, double? fontSize, FontStyle? fontStyle, FontWeight? fontWeight, Paint? foreground, double? height, double? letterSpacing, Locale? locale, List<Shadow>? shadows, TextBaseline? textBaseline, TextStyle? textStyle, double? wordSpacing}) typeface2 = GoogleFonts.libreCaslonText;
const TextStyle Function({Paint? background, Color? backgroundColor, Color? color, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, List<FontFeature>? fontFeatures, double? fontSize, FontStyle? fontStyle, FontWeight? fontWeight, Paint? foreground, double? height, double? letterSpacing, Locale? locale, List<Shadow>? shadows, TextBaseline? textBaseline, TextStyle? textStyle, double? wordSpacing}) typeface3 = GoogleFonts.lato;
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
      {required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;

    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.mPlus1(
    //     textStyle:
    //         Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 48),
    //     fontWeight: FontWeight.w900,
    //     // letterSpacing: 1,
    //     // color: textColor,
    //     // color: textColor ?? Theme.of(context).colorScheme.onSurface,
    //     // height: 1.4,
    //   );
    // }

    // cormorant fraurence sourceserif4 saira manrope interTight prommpt rubik hind msmadi leagueSpartan libreBaskerville greatVibes
    // return const TextStyle(fontFamily: 'swiss721 Medium', fontWeight: FontWeight.w400, fontSize: 30, height: 1.17, letterSpacing: 0.2);
    // return const TextStyle(fontFamily: 'swiss721 Medium', fontWeight: FontWeight.w400, fontSize: 32, height: 1.2, letterSpacing: -0.9);
    return TextStyle(fontFamily: 'caslon 540 italic', fontWeight: FontWeight.w400, fontSize: 48, color: textColor, letterSpacing: -1, height: 1.10);

    return typeface1(
      textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28),
      fontWeight: isBold ? FontWeight.w500 : FontWeight.w200,
      color: textColor,
      fontStyle: FontStyle.italic,
      height: 1.2,
      letterSpacing: -0.6,
    );
    return GoogleFonts.prompt(
      textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 52),
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      letterSpacing: 1.2,
    );
  }

  static TextStyle headline4(
      {required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     fontWeight: FontWeight.w300,
    //     letterSpacing: 1,
    //     textStyle: Theme.of(context).textTheme.titleMedium,
    //   );
    // }

    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w400, fontSize: 30, color: textColor, letterSpacing: -0.2, height: 1.12);


    return typeface1(
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 27),
      fontWeight: FontWeight.w500,
      // letterSpacing: 1,
      // color: textColor,
      color: textColor ?? Theme.of(context).colorScheme.onSurface,
      // height: 1.4,
    );
  }

  static TextStyle headline5(
      {required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.headlineSmall,
    //   );
    // }

    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w400, fontSize: 22, color: textColor, height: 1.24, letterSpacing: 0);

    return typeface2(
      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
      fontWeight: FontWeight.w600,
      color: textColor,
      // height: 1.4,
    );
  }

  static TextStyle headline6(
      {required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.headlineSmall,
    //     height: 1,
    //   );
    // }
    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w400, fontSize: 18, color: textColor, height: 1.32, letterSpacing: -0.2);

    return typeface2(
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        fontWeight: FontWeight.w600,
        color: textColor,
        // fontStyle: FontStyle.italic,
        letterSpacing: -0.5,
        // height: 1.4
    );
  }

  static TextStyle subtitle1(
      {required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 26),
    //   );
    // }
    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w400, fontSize: 18, color: textColor, height: 1);

    return typeface2(
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
        fontWeight: FontWeight.w600,
        color: textColor ?? Theme.of(context).colorScheme.onSurface,
        // letterSpacing: 1
        height: 1.17
    );
  }

  static TextStyle subtitle2(
      {required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
    //   );
    // }
    // workSansselif

    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w300, fontSize: 16, color: textColor, height: 1.44, letterSpacing: -0.2);

    return typeface3(
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17),
        fontWeight: isBold ? FontWeight.w400 : FontWeight.w700,
            // fontStyle: FontStyle.italic,
            // .copyWith(fontSize: 23)
        color: textColor ?? Theme.of(context).colorScheme.onSurface,

        // letterSpacing: -0.8,
        // height: 1.4
    );
  }

  static TextStyle body1(
      {required BuildContext context, Color? textColor, bool? isLineThrough}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 24),
    //   );
    // }
    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w100, fontSize: 14, color: textColor, letterSpacing: -0.2, height: 1);

    return typeface3(
      color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      textStyle: Theme.of(context).textTheme.titleMedium,
      fontWeight: FontWeight.w500,
      // fontStyle: FontStyle.italic,

      // fontStyle: FontStyle.italic,
      letterSpacing: 0.5,
      // height: 1.2,
      decoration: isLineThrough == true ? TextDecoration.lineThrough : null,
    );
  }

  static TextStyle body2({required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     fontSize: 15,
    //     textStyle: Theme.of(context).textTheme.titleMedium,
    //   );
    // }

    var brightness = MediaQuery.of(context).platformBrightness;

    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w300, fontSize: 14, color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant, height: 1, letterSpacing: -0.2);

    return typeface3(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        fontWeight: FontWeight.w400,
        // fontStyle: FontStyle.italic,
        // color: textColor ?? (brightness == Brightness.dark
        //     ? Colors.white.withAlpha(textLabelMedium)
        //     : Colors.black.withAlpha(textLabelMedium)),
        // height: 1.1,
        color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        // letterSpacing: 0.15
    );
  }

  static TextStyle caption({required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.bodySmall,
    //   );
    // }

    var brightness = MediaQuery.of(context).platformBrightness;

    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w300, fontSize: 12, color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant, height: 1.2, letterSpacing: 0.4);

    return typeface3(
      textStyle: Theme.of(context).textTheme.titleSmall,
      fontWeight: FontWeight.w400,
      // fontSize: 13,
      // color: textColor ?? (brightness == Brightness.dark
      //     ? Colors.white.withAlpha(textLabelMedium)
      //     : Colors.black.withAlpha(textLabelMedium)),
      color: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      height: 1.2,
      letterSpacing: 0.1,
    );
  }

  static TextStyle overline({required BuildContext context, Color? textColor}) {
    Locale currentLocale = window.locale;
    // if (currentLocale.languageCode == 'ja') {
    //   return GoogleFonts.kaiseiHarunoUmi(
    //     textStyle: Theme.of(context).textTheme.labelSmall,
    //   );
    // }

    var brightness = MediaQuery.of(context).platformBrightness;

    return TextStyle(fontFamily: 'swiss721', fontWeight: FontWeight.w300, fontSize: 10, color: textColor);

    return typeface3(
      textStyle: Theme.of(context).textTheme.labelSmall,
      fontWeight: FontWeight.w400,
      // color: textColor ?? (brightness == Brightness.dark
      //     ? Colors.white.withAlpha(textLabelMedium)
      //     : Colors.black.withAlpha(textLabelMedium)),
      color: textColor ?? Theme.of(context).colorScheme.secondary,
      // height: 1.2,
      letterSpacing: 0.5,
    );
  }
}
