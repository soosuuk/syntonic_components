import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/texts/body_1_text.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_1_text.dart';
import 'package:flutter/material.dart';

import '../texts/subtitle_2_text.dart';

/// A state of [BasicListView].
enum _SyntonicButtonStyle {
  elevated,
  outlined,
  text,
  tonal,
}

class SyntonicButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isEnabled;
  final Widget? leadingWidget;
  final double? maxWidth;
  final _SyntonicButtonStyle style;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool isExtended;
  final bool isNegative;
  final bool isLined;
  final bool isInput;
  Color? _textColor;

  SyntonicButton._(
      {required this.onTap,
      required this.text,
      required this.style,
      this.textStyle,
      this.isEnabled = true,
      this.isExtended = false,
      this.isNegative = false,
      this.leadingWidget,
      this.maxWidth,
      this.padding,
      this.isLined = false,
      this.isInput = false});
  SyntonicButton.filled(
      {required VoidCallback onTap,
      required String text,
      EdgeInsetsGeometry? padding,
      TextStyle? textStyle,
      bool isEnabled = true,
      Widget? leadingWidget,
      bool isExtended = false,
      bool isNegative = false,
      double? maxWidth})
      : this._(
            onTap: onTap,
            text: text,
            padding: padding,
            isEnabled: isEnabled,
            isExtended: isExtended,
            isNegative: isNegative,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            textStyle: textStyle,
            style: _SyntonicButtonStyle.elevated);
  SyntonicButton.tonal(
      {required VoidCallback onTap,
      required String text,
      EdgeInsetsGeometry? padding,
      TextStyle? textStyle,
      bool isExtended = false,
      bool isEnabled = true,
      bool isNegative = false,
      Widget? leadingWidget,
      double? maxWidth})
      : this._(
            onTap: onTap,
            text: text,
            padding: padding,
            isExtended: isExtended,
            isEnabled: isEnabled,
            isNegative: isNegative,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            textStyle: textStyle,
            style: _SyntonicButtonStyle.tonal);
  SyntonicButton.outlined(
      {required VoidCallback onTap,
      required String text,
      EdgeInsetsGeometry? padding,
      bool isExtended = false,
      bool isEnabled = true,
      bool isNegative = false,
      Widget? leadingWidget,
      double? maxWidth})
      : this._(
            onTap: onTap,
            text: text,
            padding: padding,
            isEnabled: isEnabled,
            isExtended: isExtended,
            isNegative: isNegative,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            style: _SyntonicButtonStyle.outlined);
  SyntonicButton.transparent(
      {VoidCallback? onTap,
      required String text,
      TextStyle? textStyle,
      bool isExtended = false,
      bool isNegative = false,
      bool isEnabled = true,
      Widget? leadingWidget,
      double? maxWidth,
      EdgeInsetsGeometry? padding,
      bool? isLined,
      bool isInput = false})
      : this._(
            onTap: onTap,
            text: text,
            isEnabled: isEnabled,
            isExtended: isExtended,
            isNegative: isNegative,
            leadingWidget: leadingWidget,
            maxWidth: maxWidth,
            textStyle: textStyle,
            style: _SyntonicButtonStyle.text,
            padding: padding,
            isLined: isLined ?? false,
            isInput: isInput);

  @override
  Widget build(BuildContext context) {
    ButtonStyle _style = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
          Theme.of(context).colorScheme.onSurface),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );

    switch (style) {
      case _SyntonicButtonStyle.elevated:
        _textColor = Theme.of(context).colorScheme.surface;
        break;
      case _SyntonicButtonStyle.outlined:
      case _SyntonicButtonStyle.tonal:
        _textColor = Theme.of(context).colorScheme.onSurface;
        break;
      case _SyntonicButtonStyle.text:
        _textColor = Theme.of(context).colorScheme.onSurface;
        break;
    }

    final Widget _button = IgnorePointer(child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (leadingWidget != null) leadingWidget!,
        if (leadingWidget != null)
          const SizedBox(
            width: 16,
          ),
        style == _SyntonicButtonStyle.text
            ? textStyle == null
            ? Subtitle2Text(
          text: text.toUpperCase(),
          textColor: isEnabled ? _textColor : Theme.of(context).colorScheme.onSurface,
        )
            : Text(
          text,
          style: textStyle,
        )
            : Subtitle2Text(
          text: text.toUpperCase(),
          textColor:
          isNegative ? Theme.of(context).colorScheme.error : (isEnabled ? _textColor ?? Theme.of(context).colorScheme.onSurface : null),
        ),
      ],
    ),);

    switch (style) {
      case _SyntonicButtonStyle.elevated:
        return Container(
          width: isExtended ? double.infinity : null,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: FilledButton(
              style: _style.copyWith(minimumSize: WidgetStateProperty.all(Size(44, 44))),
              onPressed: isEnabled ? onTap : null,
              child: _button),
        );
      case _SyntonicButtonStyle.tonal:
        return Container(
          width: isExtended ? double.infinity : null,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: FilledButton.tonal(
            style: _style.copyWith(minimumSize: WidgetStateProperty.all(Size(44, 44))),
            onPressed: isEnabled ? onTap : null,
            child: _button,
          ),
        );
      case _SyntonicButtonStyle.outlined:
        return Container(
          width: isExtended ? double.infinity : null,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(44, 44),
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  side:
                      isNegative ? BorderSide(color: Theme.of(context).colorScheme.error) : BorderSide(color: Theme.of(context).colorScheme.onSurface),),
              onPressed: isEnabled ? onTap : null,
              child: _button),
        );
      case _SyntonicButtonStyle.text:
        // if (onTap == null) {
        //   return _button;
        // }
        return Opacity(
          opacity: isInput || !isEnabled ? 0.38 : 1,
          child: TextButton(
            onPressed: isEnabled ?onTap : null,
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 20)),
              minimumSize: WidgetStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: isLined ? IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _button,
                  Container(
                    height: 0.5,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
            ) : _button
          ),
        );
    }
  }
}
