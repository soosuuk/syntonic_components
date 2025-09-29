import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';

import 'base_text.dart';

class Body1Text extends BaseText {
  @override
  @required
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  final bool? isLineThrough;
  @override
  final bool needsSeeMore;

  const Body1Text(
      {required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.left,
      this.textColor,
      Color? linkColor,
      this.maxLines,
      this.isLineThrough,
      bool needsLinkify = true,
      this.needsSeeMore = false})
      : super(linkColor: linkColor, needsLinkify: needsLinkify);

  @override
  Widget textWidget({required BuildContext context}) {
    return true
        ? Text(
      text,
      style: textStyle(context: context),
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      textAlign: textAlign,
      overflow: TextOverflow.visible,
      maxLines: null,
    )
        : SelectableText(
      text,
      style: textStyle(context: context),
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

  @override
  TextStyle textStyle({required BuildContext context}) =>
      SyntonicTextTheme.body1(
          context: context,
          textColor: textColor ?? Theme.of(context).colorScheme.onSurface,
          isLineThrough: isLineThrough);
}
