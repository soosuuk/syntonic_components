import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_tab_bar_theme.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';

import 'syntonic_app_bar_theme.dart';
import '../constants/syntonic_color.dart';

const brightness = Brightness.light;
const _primaryColor = SyntonicColor.primary_color;
const backgroundColor = Colors.white70;

ThemeData lightTheme({ColorScheme? colorScheme}) {
  ColorScheme _colorScheme = ColorScheme.fromSeed(
      seedColor: colorScheme != null ? colorScheme.primary : _primaryColor,
      brightness: Brightness.light,
      onSurface: colorScheme != null ? colorScheme.onSurface : _primaryColor.tone(30),
      surface: colorScheme != null ? colorScheme.surface : _primaryColor.tone(98),
      background: colorScheme != null ? colorScheme.background : _primaryColor.tone(98));

  return ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: primaryColor,
    colorScheme: colorScheme,
    // colorScheme: ColorScheme.light(
    //   primary: primaryColor ?? SyntonicColor.primary_color,
    //   secondary: primaryColor ?? SyntonicColor.primary_color,
    //   // surface: Color(0xFF212121),
    //   // background: Color(0xFF212121),
    //
    // ),
    // scaffoldBackgroundColor: Colors.white,
    brightness: brightness,
    tabBarTheme: SyntonicTabBarTheme.get(
        isDarkTheme: true,
        colorScheme: _colorScheme),
    // primarySwatch: SyntonicColor.materialColor,
    // elevatedButtonTheme: SyntonicElevatedButtonTheme.get(false),
    // outlinedButtonTheme: SyntonicOutlinedButtonTheme.get(false),
    // textButtonTheme: SyntonicTextButtonTheme.get(false),
    appBarTheme: SyntonicAppBarTheme.get(false),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colorScheme != null ? colorScheme.primary : _primaryColor;
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
          return colorScheme != null ? colorScheme.primary : _primaryColor;
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
          return colorScheme != null ? colorScheme.primary : _primaryColor;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colorScheme != null ? colorScheme.primary : _primaryColor;
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
