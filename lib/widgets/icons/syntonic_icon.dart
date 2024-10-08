import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_light_theme.dart';
import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';

import '../../configs/themes/syntonic_dark_theme.dart';

class SyntonicIcon extends StatelessWidget {
  final IconData icon;
  final ColorScheme? colorScheme;
  final double padding;
  final VoidCallback? onPressed;
  final IconSize size;
  final BoxShape shape;
  final bool hasBorder;
  final bool isFilledColor;

  const SyntonicIcon({
    Key? key,
    required this.icon,
    this.colorScheme,
    this.padding = 16,
    this.onPressed,
    this.size = IconSize.small,
    this.shape = BoxShape.circle,
    this.hasBorder = false,
    this.isFilledColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _iconButton = Container(
      width: size.size,
      height: size.size,
      decoration: BoxDecoration(
        color: hasBorder
            ? (isFilledColor ? Theme.of(context).colorScheme.surface : null)
            : colorScheme != null
                ? colorScheme!.primary.withOpacity(0.12)
                : Theme.of(context).colorScheme.primary.withOpacity(0.12),
        border: hasBorder
            ? Border.all(
                color: colorScheme?.primary ?? Theme.of(context).colorScheme.primary, width: 1)
            : null,
        // color: Colors.yellow,
        borderRadius:
            shape == BoxShape.circle ? null : BorderRadius.circular(21),
        shape: shape,
      ),
      child: Icon(
        icon,
        size: size.size! <= 24 ? size.size! * 0.6 : 24,
        color: colorScheme?.primary ?? Theme.of(context).colorScheme.primary,
      ),
    );

    bool _isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Theme(
          data: _isDarkTheme ? darkTheme(colorScheme: colorScheme) : lightTheme(colorScheme: colorScheme),
          child: RepaintBoundary(
            child: InkWell(
              onTap: onPressed,
              child: _iconButton,
            ),
          )),
    );
  }
}
