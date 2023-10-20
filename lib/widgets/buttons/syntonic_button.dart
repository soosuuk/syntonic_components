import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  SyntonicButton._({required this.onTap, required this.text, required this.style, this.isEnabled = true, this.leadingWidget, this.maxWidth});
  SyntonicButton.filled({required VoidCallback onTap, required String text, bool isEnabled = true, Widget? leadingWidget, double? maxWidth}) : this._(onTap: onTap, text: text, isEnabled: isEnabled, leadingWidget: leadingWidget, maxWidth: maxWidth, style: _SyntonicButtonStyle.elevated);
  SyntonicButton.tonal({required VoidCallback onTap, required String text, bool isEnabled = true, Widget? leadingWidget, double? maxWidth}) : this._(onTap: onTap, text: text, isEnabled: isEnabled, leadingWidget: leadingWidget, maxWidth: maxWidth, style: _SyntonicButtonStyle.tonal);
  SyntonicButton.outlined({required VoidCallback onTap, required String text, bool isEnabled = true, Widget? leadingWidget, double? maxWidth}) : this._(onTap: onTap, text: text, isEnabled: isEnabled, leadingWidget: leadingWidget, maxWidth: maxWidth, style: _SyntonicButtonStyle.outlined);
  SyntonicButton.transparent({required VoidCallback onTap, required String text, bool isEnabled = true, Widget? leadingWidget, double? maxWidth}) : this._(onTap: onTap, text: text, isEnabled: isEnabled, leadingWidget: leadingWidget, maxWidth: maxWidth, style: _SyntonicButtonStyle.text);

  @override
  Widget build(BuildContext context) {
    bool _isDarkTheme = MediaQuery.of(context).platformBrightness ==
        Brightness.dark;

    final Widget _button = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (this.leadingWidget != null) ? this.leadingWidget! : const SizedBox(width: 0,),
          (this.leadingWidget != null) ? const SizedBox(width: 16,) : const SizedBox(width: 0,),
          // Subtitle2Text(text: text, textColor: isEnabled ? Colors.white : (_isDarkTheme ? Colors.white : SyntonicColor.black40),),
          Text(text.toUpperCase(),
            // textColor: isEnabled ? Theme.of(context).colorScheme.primary : (_isDarkTheme ? Colors.white38 : SyntonicColor.black40),
          ),
        ],
      ),
    );

    switch (style) {
      case _SyntonicButtonStyle.elevated:
        return Container(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),child: FilledButton(
            onPressed: isEnabled ? onTap : null,
            child: _button
        ),);
      case _SyntonicButtonStyle.tonal:
        return Container(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),child: FilledButton.tonal(
            onPressed: isEnabled ? onTap : null,
            child: _button
        ),);
      case _SyntonicButtonStyle.outlined:
        return Container(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),child: OutlinedButton(
            onPressed: isEnabled ? onTap : null,
            child: _button
        ),);
      case _SyntonicButtonStyle.text:
        return TextButton(
          onPressed: onTap,
          child: _button,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),);
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

