import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/syntonic_color.dart';

class SyntonicTabBarTheme {
  static TabBarTheme get({required bool isDarkTheme, Color? primaryColor}) {
    return TabBarTheme(
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: primaryColor ?? SyntonicColor.primary_color,
                  width: 3,
                  style: BorderStyle.solid
              )
          ),
        ),
        labelColor: primaryColor ?? SyntonicColor.primary_color,
        // unselectedLabelColor:
        //     isDarkTheme ? Colors.white70 : SyntonicColor.black56
    );
  }
}
