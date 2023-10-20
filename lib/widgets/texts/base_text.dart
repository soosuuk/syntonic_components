import 'package:syntonic_components/services/navigation_service.dart';
import 'package:syntonic_components/widgets/snack_bars/syntonic_snack_bar.dart';
import 'package:flutter/cupertino.dart';
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

  RegExp get _urlRegExp => RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  const BaseText({this.linkColor, this.needsLinkify = true,});
  
  @override
  Widget build(BuildContext context) {
    // this.context = context;

    if (needsSeeMore) {
      return ExpandableText(
        text: text,
        textStyle: textStyle(context: context),
      );
    } else {
      if (textWidget is Text) {
        if (needsLinkify &&
            (textWidget as Text).overflow == TextOverflow.visible) {
          return SelectableText.rich(
            TextSpan(children: _toLinkify(text: text, context: context), style: textStyle(context: context)),
          );
        } else {
          return textWidget(context: context);
        }
      } else {
        return textWidget(context: context);
      }
    }
  }

  Widget textWidget({required BuildContext context});

  String get text;

  bool get needsSeeMore;

  TextStyle textStyle({required BuildContext context});

  /// Linkify take a piece of text and a regular expression and turns all of the regex matches in the text into clickable links.
  /// Matching things like web URLs.
  List<TextSpan> _toLinkify({required String text, required BuildContext context}) {
    List<TextSpan> textSpan = [];

    /// Get linkable text with a matched text.
    _getLinkableText({required String text}) {
      textSpan.add(
        TextSpan(
          text: text,
          style: TextStyle(color: linkColor ?? Theme.of(context).colorScheme.primary),
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
      onNonMatch: (n) => _getNormalText(text: "${n.substring(0)}"),
    );

    return textSpan;
  }
}
