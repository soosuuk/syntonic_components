import 'package:syntonic_components/widgets/texts/body_1_text.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_1_text.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

import '../texts/body_2_text.dart';

/// A state of [BasicListView].
enum _SyntonicButtonStyle {
  elevated,
  outlined,
  text,
  tonal,
}

class SyntonicButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnabled;
  final Widget? leadingWidget;
  final double? maxWidth;
  final _SyntonicButtonStyle style;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  Color? _textColor;

  SyntonicButton._(
      {required this.onTap,
      required this.text,
      required this.style,
        this.textStyle,
      this.isEnabled = true,
      this.leadingWidget,
      this.maxWidth,
      this.padding});
  SyntonicButton.filled(
      {required VoidCallback onTap,
      required String text,
        TextStyle? textStyle,
      bool isEnabled = true,
      Widget? leadingWidget,
      double? maxWidth})
      : this._(
            onTap: onTap,
            text: text,
            isEnabled: isEnabled,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            textStyle: textStyle,
            style: _SyntonicButtonStyle.elevated);
  SyntonicButton.tonal(
      {required VoidCallback onTap,
      required String text,
        TextStyle? textStyle,
      bool isEnabled = true,
      Widget? leadingWidget,
      double? maxWidth})
      : this._(
            onTap: onTap,
            text: text,
            isEnabled: isEnabled,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            textStyle: textStyle,
            style: _SyntonicButtonStyle.tonal);
  SyntonicButton.outlined(
      {required VoidCallback onTap,
      required String text,
      bool isEnabled = true,
      Widget? leadingWidget,
      double? maxWidth})
      : this._(
            onTap: onTap,
            text: text,
            isEnabled: isEnabled,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            style: _SyntonicButtonStyle.outlined);
  SyntonicButton.transparent(
      {required VoidCallback onTap,
      required String text,
        TextStyle? textStyle,
      bool isEnabled = true,
      Widget? leadingWidget,
      double? maxWidth,
      EdgeInsetsGeometry? padding})
      : this._(
            onTap: onTap,
            text: text,
            isEnabled: isEnabled,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            textStyle: textStyle,
            style: _SyntonicButtonStyle.text,
            padding: padding);

  @override
  Widget build(BuildContext context) {
    // bool _isDarkTheme = MediaQuery.of(context).platformBrightness ==
    //     Brightness.dark;
    switch (style) {
      case _SyntonicButtonStyle.elevated:
      case _SyntonicButtonStyle.tonal:
        _textColor = Theme.of(context).colorScheme.onPrimary;
        break;
      case _SyntonicButtonStyle.outlined:
      case _SyntonicButtonStyle.text:
        _textColor = Theme.of(context).colorScheme.primary;
        break;
    }

    final Widget _button = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (leadingWidget != null) leadingWidget!,
        if (leadingWidget != null)
          const SizedBox(
            width: 16,
          ),
        style == _SyntonicButtonStyle.text
            ? textStyle == null ? Body2Text( text: text,
          textColor: isEnabled ? _textColor : null,) : Headline6Text(
                text: text,
                textColor: isEnabled ? _textColor : null,
              )
            : Body2Text(
                text: text,
                textColor: isEnabled ? _textColor : null,
              ),
        // Subtitle2Text(text: text),
      ],
    );

    switch (style) {
      case _SyntonicButtonStyle.elevated:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child:
              FilledButton(onPressed: isEnabled ? onTap : null, child: _button),
        );
      case _SyntonicButtonStyle.tonal:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: FilledButton.tonal(
            onPressed: isEnabled ? onTap : null,
            child: _button,
          ),
        );
      case _SyntonicButtonStyle.outlined:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: OutlinedButton(
              onPressed: isEnabled ? onTap : null, child: _button),
        );
      case _SyntonicButtonStyle.text:
        return TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding:
                padding != null ? MaterialStateProperty.all(padding) : null,
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: _button,
        );
    }

    // return OutlinedButton(
    //   onPressed: onTap,
    //   child: Stack(
    //     alignment: Alignment.centerLeft,
    //     children: <Widget>[
    //       Icon(leadingIcon, color: Theme.of(context).colorScheme.primary),
    //       Padding(
    //         padding: EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
    //         child: Row(
    //           children: <Widget>[
    //             Padding(
    //               padding: EdgeInsets.only(left: 16.0),
    //               child: Subtitle2Text(text: text),
    //             )
    //           ],
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: <Widget>[
    //           Icon(trailingIcon, color: SyntonicColor.mid_gray),
    //         ],
    //       ),
    //     ],
    //   ),
    //   style: OutlinedButton.styleFrom(
    //     primary: SyntonicColor.black88,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //   ),
    // );
  }
}
