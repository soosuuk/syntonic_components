import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicBannerTheme {
  static MaterialBannerThemeData get(bool isDarkTheme) {
    return MaterialBannerThemeData(
        backgroundColor:
            isDarkTheme ? SyntonicColor.black72 : SyntonicColor.black4);
  }
}
