import 'dart:ui';

import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syntonic_components/widgets/texts/overline_text.dart';

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
  final Widget? trailing;
  final bool isDotted;

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
    this.trailing,
    this.isDotted = false,
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
                  horizontal: isFilled ? 8 : 7, vertical: isFilled ? 4 : 3),
              decoration: BoxDecoration(
                  border: isFilled
                      ? null
                      : Border.all(
                          color: (constColor != null)
                              ? constColor!
                              : _isDarkTheme
                                  ? Colors.white38
                                  : Colors.black38,
                          style:
                              isDotted ? BorderStyle.none : BorderStyle.solid),
                  borderRadius: BorderRadius.circular(4),
                  color: isFilled ? color ?? Colors.black54 : null),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Container(
                      padding: const EdgeInsets.only(right: 4),
                      child: icon!,
                    ),
                  if (text != null)
                    Flexible(
                      child: Opacity(
                        opacity: isDotted ? 0.38 : 1,
                        child: OverlineText(
                          text: text!,
                          textColor: isFilled
                              ? color?.optimalColor
                              : Theme.of(context).colorScheme.onSurface,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  if (child != null) Flexible(child: child!),
                  if (trailing != null) ...[
                    const SizedBox(
                      width: 4,
                    ),
                    trailing!
                  ],
                  // if (onTap != null)
                  //   Icon(
                  //     Icons.keyboard_arrow_right,
                  //     size: 16,
                  //     color: color,
                  //   ),
                  if (onDeleted != null)
                    Row(
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
                    ),
                ],
              )),
          if (isDotted && !isFilled)
            Positioned.fill(
              child: CustomPaint(
                painter: _DottedBorderPainter(
                  color: (constColor != null)
                      ? constColor!
                      : _isDarkTheme
                          ? Colors.white38
                          : Colors.black38,
                ),
              ),
            ),
          if (onTap != null)
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: inkColor,
                      highlightColor: inkColor,
                      hoverColor: inkColor,
                      onTap: onTap,
                    ))),
        ],
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;

  _DottedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(4)));

    final Path dashPath = Path();
    const double dashWidth = 2.0;
    const double dashSpace = 2.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
