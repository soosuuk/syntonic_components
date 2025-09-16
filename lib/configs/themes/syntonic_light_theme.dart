import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_tab_bar_theme.dart';

import 'syntonic_app_bar_theme.dart';
import '../constants/syntonic_color.dart';

const brightness = Brightness.light;
const _primaryColor = SyntonicColor.primary_color;
const backgroundColor = Colors.white70;

Color increaseSaturation(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final hslSaturated =
      hsl.withSaturation((hsl.saturation + amount).clamp(0.0, 1.0));
  return hslSaturated.toColor();
}

ThemeData lightTheme({ColorScheme? colorScheme}) {
  ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: colorScheme != null
        ? increaseSaturation(colorScheme.primary, 100)
        : increaseSaturation(_primaryColor, 0.2),
    brightness: Brightness.light,
    surface: Colors.white,
      surfaceContainerHigh: Colors.white,
    primary: increaseSaturation(colorScheme?.primary ?? _primaryColor, 0.8),
    primaryContainer:
        increaseSaturation(colorScheme?.primaryContainer ?? _primaryColor, 1),
    onSurface: const Color(0xFF000000),
    onSurfaceVariant: const Color(0xFF707070),
    background: Colors.white,
    outline: SyntonicColor().divider,
    outlineVariant: Colors.black.withOpacity(0.145),
  );

  return ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: primaryColor,
    dividerColor: Colors.transparent,
    colorScheme: _colorScheme,
    // colorScheme: ColorScheme.light(
    //   primary: primaryColor ?? SyntonicColor.primary_color,
    //   secondary: primaryColor ?? SyntonicColor.primary_color,
    //   // surface: Color(0xFF212121),
    //   // background: Color(0xFF212121),
    //
    // ),
    // scaffoldBackgroundColor: Colors.white,
    dialogTheme: DialogThemeData(
      backgroundColor: _colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    brightness: brightness,
    tabBarTheme:
        SyntonicTabBarTheme.get(isDarkTheme: false, colorScheme: _colorScheme),
    // primarySwatch: SyntonicColor.materialColor,
    // elevatedButtonTheme: SyntonicElevatedButtonTheme.get(false),
    // outlinedButtonTheme: SyntonicOutlinedButtonTheme.get(false),
    // textButtonTheme: SyntonicTextButtonTheme.get(false),
    appBarTheme: SyntonicAppBarTheme.get(false),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme != null ? colorScheme.primary : _primaryColor;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme != null ? colorScheme.primary : _primaryColor;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme != null ? colorScheme.primary : _primaryColor;
        }
        return null;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
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
