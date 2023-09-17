import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/cupertino.dart';

import 'base_text.dart';

class Headline6Text extends BaseText {
  @required
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final Color? textColor;
  final int? maxLines;
  final bool needsSeeMore;

  Headline6Text(
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
  Widget get textWidget {
    return Text(
      this.text.capitalize(),
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
  TextStyle get textStyle => SyntonicTextTheme.headline6(context: context, textColor: textColor);
}
