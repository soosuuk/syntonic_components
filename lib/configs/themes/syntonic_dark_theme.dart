import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/services/navigation_service.dart';

import '../constants/syntonic_color.dart';
import 'syntonic_tab_bar_theme.dart';

const brightness = Brightness.dark;
const primaryColor = Colors.black87;
const backgroundColor = Colors.white70;

ThemeData darkTheme({ColorScheme? colorScheme}) {
  // late Color primary;
  // if (colorScheme != null) {
  //   HSLColor hslColor = HSLColor.fromColor(colorScheme.primary);
  //   double newSaturation = (hslColor.saturation + 0.6).clamp(0.0, 1.0);
  //   double newLightness = (hslColor.lightness + 0.5).clamp(0.0, 1.0);
  //   HSLColor moreVividHslColor = hslColor.withSaturation(newSaturation).withLightness(newLightness);
  //   primary = moreVividHslColor.toColor();
  // }

  ColorScheme _colorScheme = ColorScheme.fromSeed(
      seedColor: colorScheme != null ? colorScheme.primary : SyntonicColor.primary_color,
      brightness: Brightness.dark,
      onPrimaryContainer: Colors.white,
      surface: colorScheme != null ? colorScheme.surface.tone(0) : null,
      onSurface: colorScheme != null ? colorScheme.primary.tone(100) : SyntonicColor.primary_color
          .tone(100)
  );
  return ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: primaryColor,
    colorScheme: _colorScheme,
    // .dark(
    // onSurface: primaryColor!.tone(50),
    // surface: SyntonicColor.raisinBlack,
    // background: SyntonicColor.raisinBlack,

    // ),
    applyElevationOverlayColor: true,
    // scaffoldBackgroundColor: SyntonicColor.raisinBlack,
    brightness: brightness,
    // primarySwatch: SyntonicColor.materialColor,
    // elevatedButtonTheme: SyntonicElevatedButtonTheme.get(true),
    // outlinedButtonTheme: SyntonicOutlinedButtonTheme.get(true),
    // textButtonTheme: SyntonicTextButtonTheme.get(true),
    // appBarTheme: SyntonicAppBarTheme.get(true),
    tabBarTheme: SyntonicTabBarTheme.get(
        isDarkTheme: true,
        colorScheme: _colorScheme),
    // bottomNavigationBarTheme: SyntonicBottomNavigationBarTheme.get(true),
    // dialogTheme: SyntonicDialogTheme.get(true),
    // chipTheme: SyntonicChipTheme.get(true),
    // bannerTheme: SyntonicBannerTheme.get(true),
    //
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: SyntonicColor.primary_color,
    //   foregroundColor: SyntonicColor.black88,
    // ),
    dividerColor: Colors.transparent,
    cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(color: Colors.white),
        )),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return primaryColor ?? SyntonicColor.primary_color;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return primaryColor ?? SyntonicColor.primary_color;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return primaryColor ?? SyntonicColor.primary_color;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return primaryColor ?? SyntonicColor.primary_color;
        }
        return null;
      }),
    ),

    // iconTheme:
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
  );
}
