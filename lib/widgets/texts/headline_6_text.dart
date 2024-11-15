import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/cupertino.dart';

import 'base_text.dart';

class Headline6Text extends BaseText {
  @override
  @required
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  @override
  final bool needsSeeMore;

  const Headline6Text(
      {required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.left,
      this.textColor,
      Color? linkColor,
      this.maxLines,
      bool needsLinkify = false,
      this.needsSeeMore = false})
      : super(linkColor: linkColor, needsLinkify: needsLinkify);

  @override
  Widget textWidget({required BuildContext context}) {
    return Text(
      text.capitalize(),
      style: textStyle(context: context),
      textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      textAlign: textAlign,
      overflow: needsSeeMore ? TextOverflow.visible : overflow,
      maxLines: needsSeeMore ? null : maxLines,
    );
  }

  @override
  TextStyle textStyle({required BuildContext context}) =>
      SyntonicTextTheme.headline6(context: context, textColor: textColor ?? Theme.of(context).colorScheme.onSurfaceVariant);
}
