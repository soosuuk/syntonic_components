import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/mybusinesslodging/v1.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/headline_4_text.dart';
import 'package:syntonic_components/widgets/texts/headline_5_text.dart';
import 'package:syntonic_components/widgets/texts/overline_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

import '../../configs/themes/syntonic_dark_theme.dart';
import '../../configs/themes/syntonic_light_theme.dart';

class SyntonicChart extends StatelessWidget {
  final Color? color;
  final int? basedValue;
  final int value;
  final IconData? icon;
  final String title;
  final VoidCallback? onTap;
  final double height;
  const SyntonicChart({Key? key, required this.value, this.color, this.basedValue, this.onTap, this.icon, required this.title, this.height = 120}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = height;
    final double percentage = basedValue != null ? value / basedValue! * 100 : 0;
    final double _valueHeight = _height * percentage / 100;
    bool isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    ThemeData _theme = color != null ? isDarkTheme ? darkTheme(primaryColor: color) : lightTheme(primaryColor: color) : Theme.of(context);
    Color? inkColor = onTap != null ? null : Colors.transparent;

    return Theme(data: _theme, child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(10)), child: InkWell(
      splashColor: inkColor,
      highlightColor: inkColor,
      hoverColor: inkColor,
      onTap: onTap, child: Container(height: _height, decoration: BoxDecoration(
      color: basedValue != null ? _theme.colorScheme.primary.tone(isDarkTheme? 40 : 5).toAlpha : _theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      border: basedValue == null ? Border.all(
        width: 1.4,
        color: _theme.colorScheme.outlineVariant,
      ) : null,
    ),
      child: Stack(alignment: Alignment.bottomLeft, children: [
        basedValue != null ? Container(width: _valueHeight, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _theme.colorScheme.primary.tone(isDarkTheme ? 20 : 80),
          // borderRadius: BorderRadius.circular(40),
        )) : SizedBox(width: height),
        Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          basedValue != null ? Row(children: [Icon(icon, size: 18, color: color,), const SizedBox(width: 8,), Flexible(child: Body2Text(text:  '1・120k'))],) : const SizedBox(),
          // const SizedBox(height: 8,),
          // Body2Text(text: '${value}K'),
        ],))],),),),));
  }
}
