import 'package:syntonic_components/services/navigation_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'expandable_text.dart';

abstract class BaseText extends StatelessWidget {
  // late BuildContext context;

  /// Apply linkify to text depending on text style
  /// The default value of body 1, body 2, caption is true.
  final bool needsLinkify;

  /// Link color.
  final Color? linkColor;

  /// Widget to display at the end of the text as a WidgetSpan.
  final Widget? trailingWidget;

  RegExp get _urlRegExp => RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  const BaseText({
    this.linkColor,
    this.needsLinkify = true,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    // this.context = context;

    if (needsSeeMore) {
      return ExpandableText(
        text: text,
        textStyle: textStyle(context: context),
      );
    } else {
      // maxLinesが設定されている場合は、linkifyを適用しない
      final shouldLinkify = needsLinkify && 
                           getMaxLines() == null && 
                           _urlRegExp.hasMatch(text);
      
      if (shouldLinkify) {
        final spans = _toLinkify(text: text, context: context);
        if (trailingWidget != null) {
          spans.add(WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: trailingWidget!,
          ));
        }
        return SelectableText.rich(
          TextSpan(
              children: spans,
              style: textStyle(context: context)),
        );
      } else {
        // trailingWidgetがある場合は、Text.richを使用
        if (trailingWidget != null) {
          return textWidgetWithTrailing(context: context);
        } else {
          return textWidget(context: context);
        }
      }
    }
  }
  
  /// Text widget with trailing widget using Text.rich
  Widget textWidgetWithTrailing({required BuildContext context}) {
    return Text.rich(
      TextSpan(
        text: text,
        style: textStyle(context: context),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: trailingWidget!,
          ),
        ],
      ),
      textAlign: getTextAlign(),
      overflow: getOverflow(),
      maxLines: getMaxLines(),
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
    );
  }
  
  TextAlign getTextAlign() => TextAlign.left;
  TextOverflow getOverflow() => TextOverflow.visible;
  int? getMaxLines() => null;

  Widget textWidget({required BuildContext context});

  String get text;

  bool get needsSeeMore;

  TextStyle textStyle({required BuildContext context});

  /// Linkify take a piece of text and a regular expression and turns all of the regex matches in the text into clickable links.
  /// Matching things like web URLs.
  List<InlineSpan> _toLinkify(
      {required String text, required BuildContext context}) {
    List<InlineSpan> textSpan = [];

    /// Get linkable text with a matched text.
    _getLinkableText({required String text}) {
      textSpan.add(
        TextSpan(
          text: text,
          style: TextStyle(
              color: linkColor ?? Theme.of(context).colorScheme.primary),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              NavigationService.launchUrlInApp(url: text);
            },
        ),
      );
      return text;
    }

    /// Get normal text with a non-matched text.
    _getNormalText({required String text}) {
      textSpan.add(
        TextSpan(
          text: text,
        ),
      );
      return text;
    }

    text.splitMapJoin(
      _urlRegExp,
      onMatch: (m) => _getLinkableText(text: "${m.group(0)}"),
      onNonMatch: (n) => _getNormalText(text: n.substring(0)),
    );

    return textSpan;
  }
}
