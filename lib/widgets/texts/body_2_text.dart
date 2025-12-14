import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:flutter/cupertino.dart';

import 'base_text.dart';

class Body2Text extends BaseText {
  @override
  @required
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  @override
  final bool needsSeeMore;

  const Body2Text(
      {required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.left,
      this.textColor,
      Color? linkColor,
      this.maxLines,
      bool needsLinkify = true,
      this.needsSeeMore = false,
      Widget? trailingWidget})
      : super(linkColor: linkColor, needsLinkify: needsLinkify, trailingWidget: trailingWidget);

  @override
  Widget textWidget({required BuildContext context}) {
    return Text(
      text,
      style: textStyle(context: context),
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  @override
  TextStyle textStyle({required BuildContext context}) =>
      SyntonicTextTheme.body2(context: context, textColor: textColor);
  
  @override
  TextAlign getTextAlign() => textAlign;
  
  @override
  TextOverflow getOverflow() => overflow;
  
  @override
  int? getMaxLines() => maxLines;
}
