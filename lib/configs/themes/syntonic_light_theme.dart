import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';

import 'syntonic_app_bar_theme.dart';
import '../constants/syntonic_color.dart';
import 'syntonic_tab_bar_theme.dart';

const brightness = Brightness.light;
const primaryColor = SyntonicColor.primary_color;
const backgroundColor = Colors.white70;

ThemeData lightTheme({Color? primaryColor}) {
  return ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor!, brightness: Brightness.light, onSurface: primaryColor.tone(30), surface: primaryColor.tone(95), background: primaryColor.tone(95)),
    // colorScheme: ColorScheme.light(
    //   primary: primaryColor ?? SyntonicColor.primary_color,
    //   secondary: primaryColor ?? SyntonicColor.primary_color,
    //   // surface: Color(0xFF212121),
    //   // background: Color(0xFF212121),
    //
    // ),
    // scaffoldBackgroundColor: Colors.white,
    brightness: brightness,
    // primarySwatch: SyntonicColor.materialColor,
    // elevatedButtonTheme: SyntonicElevatedButtonTheme.get(false),
    // outlinedButtonTheme: SyntonicOutlinedButtonTheme.get(false),
    // textButtonTheme: SyntonicTextButtonTheme.get(false),
    appBarTheme: SyntonicAppBarTheme.get(false),
    // tabBarTheme: SyntonicTabBarTheme.get(isDarkTheme: false, primaryColor: primaryColor),
    // bottomNavigationBarTheme: SyntonicBottomNavigationBarTheme.get(false),
    // dialogTheme: SyntonicDialogTheme.get(false),
    // chipTheme: SyntonicChipTheme.get(false),
    // bannerTheme: SyntonicBannerTheme.get(false),
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: primaryColor,
    //   foregroundColor: Colors.white,
    // ),
    // dividerColor: Colors.transparent,
    toggleableActiveColor: primaryColor ?? SyntonicColor.primary_color,
    // iconTheme:
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
  );
}

