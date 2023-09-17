import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:flutter/cupertino.dart';

import 'base_text.dart';

class CaptionText extends BaseText {
  @required
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  final bool needsSeeMore;

  CaptionText(
      {required this.text,
      this.overflow = TextOverflow.visible,
      this.textAlign = TextAlign.left,
      this.textColor,
      Color? linkColor,
      this.maxLines,
      bool needsLinkify = true,
      this.needsSeeMore = false})
      : super(linkColor: linkColor, needsLinkify: needsLinkify);

  @override
  Widget get textWidget {
    return Text(
      this.text,
      style: textStyle,
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
  TextStyle get textStyle => SyntonicTextTheme.caption(context: context, textColor: textColor);
}
