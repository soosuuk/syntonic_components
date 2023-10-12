import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/mybusinesslodging/v1.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/headline_4_text.dart';
import 'package:syntonic_components/widgets/texts/headline_5_text.dart';
import 'package:syntonic_components/widgets/texts/overline_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

import '../../configs/themes/syntonic_dark_theme.dart';
import '../../configs/themes/syntonic_light_theme.dart';

class SyntonicBarChart extends StatelessWidget {
  Color? color;
  int? basedValue;
  SyntonicBarChart({this.color, this.basedValue});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    ThemeData _theme = color != null ? isDarkTheme ? darkTheme(primaryColor: color) : lightTheme(primaryColor: color) : Theme.of(context);
    return Theme(data: _theme, child: Container(height: 120, decoration: BoxDecoration(
      color: basedValue != null ? _theme.colorScheme.primary.tone(95) : _theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(40),
      border: basedValue == null ? Border.all(
        width: 1.4,
        color: _theme.colorScheme.outlineVariant,
      ) : null,
    ), child: Stack(alignment: Alignment.bottomLeft, children: [
      basedValue != null ? Container(height: 70, decoration: BoxDecoration(
        color: _theme.colorScheme.primary.tone(80),
        borderRadius: BorderRadius.circular(40),
      )) : const SizedBox(),
      Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        basedValue != null ? Icon(Icons.train) : const SizedBox(),
      SizedBox(height: 8,),
      Body2Text(text: 'Transportation'),
      Headline4Text(text: '23K'),
    ],))],),));
  }
}
