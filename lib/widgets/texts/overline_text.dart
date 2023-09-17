import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:flutter/cupertino.dart';

import 'base_text.dart';

class OverlineText extends BaseText {
  @Deprecated('Should use "Label" instead of this parameter')
  final Color? backgroundColor;

  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  final bool needsSeeMore;

  OverlineText(
      {required this.text,
      this.backgroundColor,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.left,
      this.textColor,
      Color? linkColor,
      this.maxLines,
      bool needsLinkify = false,
      this.needsSeeMore = false})
      : super(linkColor: linkColor, needsLinkify: needsLinkify);

  @override
  Widget get textWidget {
    return Container(
        padding: backgroundColor != null ? EdgeInsets.all(4) : null,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(2),
            color: backgroundColor),
        child: Text(
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
        ));
  }

  @override
  TextStyle get textStyle => SyntonicTextTheme.overline(context: context, textColor: textColor);
}
