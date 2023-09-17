import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:flutter/cupertino.dart';

import 'base_text.dart';

class Subtitle2Text extends BaseText {
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  final bool needsSeeMore;
  final bool needsLineThrough;

  Subtitle2Text(
      {required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.left,
      this.textColor,
      Color? linkColor,
      this.maxLines,
      bool needsLinkify = false,
      this.needsSeeMore = false,
      this.needsLineThrough = false})
      : super(linkColor: linkColor, needsLinkify: needsLinkify);

  @override
  Widget get textWidget {
    return Text(
      this.text,
      style: (needsLineThrough) ? lineThroughStyle : textStyle,
      textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      textAlign: textAlign,
      overflow: needsSeeMore
          ? TextOverflow.visible
          : overflow,
      maxLines: needsSeeMore
          ? null
          : maxLines,
    );
  }

  @override
  TextStyle get textStyle => SyntonicTextTheme.subtitle2(context: context, textColor: textColor);

  TextStyle get lineThroughStyle => SyntonicTextTheme.subtitle2WithLineThrough(context: context, textColor: textColor);
}
