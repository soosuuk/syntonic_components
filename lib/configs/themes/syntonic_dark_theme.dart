import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/services/navigation_service.dart';

import '../constants/syntonic_color.dart';
import 'syntonic_tab_bar_theme.dart';

const brightness = Brightness.dark;
const primaryColor = Colors.black87;
const backgroundColor = Colors.white70;

ThemeData darkTheme({Color? primaryColor}) {
  return ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor ?? SyntonicColor.primary_color, brightness: Brightness.dark, onSurface: (primaryColor ?? SyntonicColor.primary_color).tone(95)),
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
    tabBarTheme: SyntonicTabBarTheme.get(isDarkTheme: true, primaryColor: primaryColor),
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
    toggleableActiveColor: primaryColor ?? SyntonicColor.primary_color,
    cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle:
        TextStyle(color: Colors.white),
      )
    ),


    // iconTheme:
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
  );
}
