import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/headline_4_text.dart';

import '../../configs/themes/syntonic_dark_theme.dart';
import '../../configs/themes/syntonic_light_theme.dart';

class SyntonicBarChart extends StatelessWidget {
  final ColorScheme? colorScheme;
  final int? basedValue;
  final int value;
  final IconData? icon;
  final String title;
  final VoidCallback? onTap;
  final double height;
  const SyntonicBarChart(
      {Key? key,
      required this.value,
      this.colorScheme,
      this.basedValue,
      this.onTap,
      this.icon,
      required this.title,
      this.height = 120})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = height;
    final double percentage =
        basedValue != null ? value / basedValue! * 100 : 0;
    final double _valueHeight = _height * percentage / 100;
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    ThemeData _theme = colorScheme != null
        ? isDarkTheme
            ? darkTheme(colorScheme: colorScheme)
            : lightTheme(colorScheme: colorScheme)
        : Theme.of(context);
    Color? inkColor = onTap != null ? null : Colors.transparent;

    return Theme(
        data: _theme,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: InkWell(
            splashColor: inkColor,
            highlightColor: inkColor,
            hoverColor: inkColor,
            onTap: onTap,
            child: Container(
              height: _height,
              decoration: BoxDecoration(
                color: basedValue != null
                    ? _theme.colorScheme.primary.tone(isDarkTheme ? 5 : 95)
                    : _theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(40),
                border: basedValue == null
                    ? Border.all(
                        width: 1.4,
                        color: _theme.colorScheme.outlineVariant,
                      )
                    : null,
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  basedValue != null
                      ? Container(
                          width: height,
                          height: _valueHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: _theme.colorScheme.primary
                                .tone(isDarkTheme ? 15 : 80),
                            // borderRadius: BorderRadius.circular(40),
                          ))
                      : SizedBox(width: height),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          basedValue != null ? Icon(icon) : const SizedBox(),
                          const SizedBox(
                            height: 8,
                          ),
                          Body2Text(text: title),
                          Headline4Text(text: '${value}K'),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
