import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SyntonicColor {
  static const MaterialColor materialColor = MaterialColor(
    0xFF08CBDB,
    <int, Color>{
      50: Color(0xFF08CBDB),
      100: Color(0xFF08CBDB),
      200: Color(0xFF08CBDB),
      300: Color(0xFF08CBDB),
      400: Color(0xFF08CBDB),
      500: Color(0xFF08CBDB),
      600: Color(0xFF08CBDB),
      700: Color(0xFF08CBDB),
      800: Color(0xFF08CBDB),
      900: Color(0xFF08CBDB),
    },
  );

  static const Color primary_color = Color(0xFF08CBDB);
  static const Color primary_color64 = Color(0xA308CBDB);
  static const Color primary_color12 = Color(0x1F08CBDB);

  @Deprecated("Should replace to black/white with alpha color.")
  static const Color gainsboro = Color(0xFFDCDCDC);

  @Deprecated("Should replace to black/white with alpha color.")
  static const Color concrete = Color(0xFFF2F2F2);

  static const Color forest_green = Color(0xFF1DC321);
  static const Color forest_green64 = Color(0xA31DC321);
  static const Color forest_green12 = Color(0x1F1DC321);

  static const Color radiance = Color(0xFF1877F2);
  static const Color radiance64 = Color(0xA31877F2);
  static const Color radiance12 = Color(0x1F1877F2);

  static const Color brown = Color(0xFFB56E2A);
  static const Color brown64 = Color(0xA3B56E2A);
  static const Color brown12 = Color(0x1FB56E2A);

  static const Color torch_red = Color(0xFFF90C1A);
  static const Color torch_red54 = Color(0xA3F90C1A);
  static const Color torch_red12 = Color(0x1FF90C1A);

  static const Color orange = Color(0xFFFD683A);
  static const Color orange64 = Color(0xA3FD683A);
  static const Color orange12 = Color(0x1FFD683A);

  static const Color yellow = Color(0xFFFEDB41);
  static const Color yellow64 = Color(0xA3FEDB41);
  static const Color yellow12 = Color(0x1FFEDB41);

  static const Color gold = Color(0xFFF7DDA5);
  static const Color gold54 = Color(0xA3F7DDA5);
  static const Color gold12 = Color(0x1FF7DDA5);

  static const Color silver = Color(0xFFDED6C6);
  static const Color silver64 = Color(0xA3DED6C6);
  static const Color silver12 = Color(0x1FDED6C6);

  static const Color yellow_green = Color(0xFFA6DB2B);
  static const Color yellow_green64 = Color(0xA3A6DB2B);
  static const Color yellow_green12 = Color(0x1FA6DB2B);

  static const Color lime_green = Color(0xFF27BA3D);
  static const Color lime_green64 = Color(0xA327BA3D);
  static const Color lime_green12 = Color(0x1F27BA3D);

  static const Color cornflower_blue = Color(0xFF587BF0);
  static const Color cornflower_blue64 = Color(0xA3587BF0);
  static const Color cornflower_blue12 = Color(0x1F587BF0);

  static const Color electric_purple = Color(0xFFB42CFC);
  static const Color electric_purple64 = Color(0xA3B42CFC);
  static const Color electric_purple12 = Color(0x1FB42CFC);

  static const Color pink = Color(0xFFFF84D0);
  static const Color pink64 = Color(0xA3FF84D0);
  static const Color pink12 = Color(0x1FFF84D0);

  static const Color violet_red = Color(0xFFFA428F);
  static const Color violet_red64 = Color(0xA3FA428F);
  static const Color violet_red12 = Color(0x1FFA428F);

  static const Color activated_blue = Color(0xFF4d00dd);
  static const Color activated_blue64 = Color(0xA34d00dd);
  static const Color activated_blue12 = Color(0x1F4d00dd);

  static const Color mid_gray = Color(0xFF61626A);

  /// Surface color of dark theme.
  static const Color raisinBlack = Color(0xFF202124);

  @Deprecated("Should replace to black/white with alpha color.")
  static const Color gray12 = Color(0x1F61626A);

  @Deprecated("Should replace to black/white with alpha color.")
  static const Color enable_bg_gray = Color(0x28979797);

  /// Black with 88% opacity.
  ///
  /// Used for dialog content text in light themes and evaluated button theme in dark themes.
  ///
  /// See also:
  ///
  ///  * [black72], [black56], [black52], [black40], [black4] which
  ///    are variants on this color but with different opacities.
  static const Color black88 = Color(0xE0000000);

  /// Black with 72% opacity.
  ///
  /// Used for banner background color in dark themes and medal black.
  ///
  /// See also:
  ///
  ///  * [black88], [black56], [black52], [black40], [black4] which
  ///    are variants on this color but with different opacities.
  static const Color black72 = Color(0xB8000000);

  /// Black with 56% opacity.
  ///
  /// See also:
  ///
  ///  * [black88], [black72], [black52], [black40], [black4] which
  ///    are variants on this color but with different opacities.
  static const Color black56 = Color(0x8F000000);

  /// Black with 52% opacity.
  ///
  /// Used for circle buttons in light themes.
  ///
  /// See also:
  ///
  ///  * [black88], [black72], [black56], [black40], [black4] which
  ///    are variants on this color but with different opacities.
  static const Color black52 = Color(0x85000000);

  /// Black with 40% opacity.
  ///
  /// Used for disable background, drop down arrow, text and border in light themes.
  ///
  /// See also:
  ///
  ///  * [black88], [black72], [black56], [black52], [black4] which
  ///    are variants on this color but with different opacities.
  static const Color black40 = Color(0x66000000);

  /// Black with 4% opacity.
  ///
  /// Used for banner background color in light themes.
  ///
  /// See also:
  ///
  ///  * [black88], [black72], [black56], [black52], [black40] which
  ///    are variants on this color but with different opacities.
  static const Color black4 = Color(0x0a000000);

  static const Color black12 = Color(0x1F000000);

  /// White with 4% opacity.
  ///
  /// Used for banner background color in light themes.
  static const Color white4 = Color(0x0affffff);

  static const Color whiteTransparent = Color(0x00FFFFFF);

  Brightness brightness = SchedulerBinding.instance.window.platformBrightness;

  Color backgroundFilled = black4;
  Color divider = black12;
  Color selected = primary_color12;
  Color onSelected = primary_color;
  Color unSelected = white4;
  Color onUnSelected = black40; // variable nameがおかしい？
  Color techniqueCategoryIconBorder = black12;
  Color homeTimeCardBackground = black4;
  Color techniqueCategoryColorDefault = whiteTransparent;
  Color techniqueCategoryColor1 = black40;
  Color techniqueCategoryColor2 = primary_color;
  Color techniqueCategoryColor3 = torch_red;
  Color techniqueCategoryColor4 = orange;
  Color techniqueCategoryColor5 = yellow;
  Color techniqueCategoryColor6 = yellow_green;
  Color techniqueCategoryColor7 = lime_green;
  Color techniqueCategoryColor8 = cornflower_blue;
  Color techniqueCategoryColor9 = electric_purple;
  Color techniqueCategoryColor10 = pink;

  List<Color> get techniqueCategoryColorList {
    return [
      techniqueCategoryColorDefault,
      techniqueCategoryColor1,
      techniqueCategoryColor2,
      techniqueCategoryColor3,
      techniqueCategoryColor4,
      techniqueCategoryColor5,
      techniqueCategoryColor6,
      techniqueCategoryColor7,
      techniqueCategoryColor8,
      techniqueCategoryColor9,
      techniqueCategoryColor10
    ];
  }

  SyntonicColor() {
    if (brightness == Brightness.dark) {
      backgroundFilled = white4;
      divider = Colors.white12;
      selected = primary_color12;
      onSelected = primary_color;
      onUnSelected = silver64;
      unSelected = silver12;
      techniqueCategoryIconBorder = silver12;
      homeTimeCardBackground = Colors.white12;
      techniqueCategoryColorDefault = whiteTransparent;
      techniqueCategoryColor1 = silver12;
      techniqueCategoryColor2 = primary_color;
      techniqueCategoryColor3 = torch_red;
      techniqueCategoryColor4 = orange;
      techniqueCategoryColor5 = yellow;
      techniqueCategoryColor6 = yellow_green;
      techniqueCategoryColor7 = lime_green;
      techniqueCategoryColor8 = cornflower_blue;
      techniqueCategoryColor9 = electric_purple;
      techniqueCategoryColor10 = pink;
    }
  }
}
