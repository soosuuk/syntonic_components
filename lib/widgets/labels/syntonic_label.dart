import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SyntonicLabel extends StatelessWidget {
  @required
  final String? text;
  late Color? color;
  late Color? constColor;
  late Color? _colorAlpha12;
  final bool isFilled;
  final bool hasPadding;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final Widget? icon;
  final Widget? child;

  SyntonicLabel({
    this.text,
    this.color,
    this.constColor,
    this.isFilled = true,
    this.hasPadding = true,
    this.onTap,
    this.onDeleted,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool _isDarkTheme = brightness == Brightness.dark;
    color = color ?? Theme.of(context).colorScheme.primary;
    double _double = 12 / 100;
    _colorAlpha12 = color!.withOpacity(_double);
    Color? inkColor;
    if (onTap == null) {
      inkColor = Colors.transparent;
    }

    return Container(
      padding: hasPadding ? const EdgeInsets.all(8) : null,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: isFilled ? 4 : 3, vertical: isFilled ? 4 : 3),
              // padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  border: isFilled
                      ? null
                      : Border.all(
                          color: (constColor != null)
                              ? constColor!
                              : _isDarkTheme
                                  ? Colors.white38
                                  : Colors.black38),
                  borderRadius: BorderRadius.circular(4),
                  // color: isFilled ? _colorAlpha12 : null
                  color: color ?? Colors.black54),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (icon != null)
                      ? Container(
                          padding: const EdgeInsets.only(right: 4),
                          child: icon!,
                        )
                      : const SizedBox(),
                  text != null
                      ? Flexible(
                          child: CaptionText(
                          text: text!,
                          // textColor: isFilled ? color : (constColor != null) ? constColor! : null,
                          textColor: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ))
                      : const SizedBox(),
                  child ?? const SizedBox(),
                  onTap != null
                      ? Icon(
                          Icons.keyboard_arrow_right,
                          size: 16,
                          color: color,
                        )
                      : const SizedBox(),
                  onDeleted != null
                      ? Row(
                          children: [
                            SizedBox(
                                height: 12,
                                child: VerticalDivider(
                                    color: _isDarkTheme
                                        ? Colors.white38
                                        : Colors.black38)),
                            InkWell(
                                onTap: onDeleted,
                                child: Icon(Icons.close,
                                    size: 12,
                                    color: _isDarkTheme
                                        ? Colors.white38
                                        : Colors.black38)),
                          ],
                        )
                      : const SizedBox(),
                ],
              )),
          onTap != null
              ? Positioned.fill(
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: inkColor,
                        highlightColor: inkColor,
                        hoverColor: inkColor,
                        onTap: onTap,
                      )))
              : const SizedBox(),
        ],
      ),
    );
  }
}
