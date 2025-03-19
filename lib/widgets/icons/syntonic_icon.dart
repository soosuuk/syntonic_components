import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/themes/syntonic_light_theme.dart';
import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';

import '../../configs/themes/syntonic_dark_theme.dart';

class SyntonicIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double padding;
  final VoidCallback? onPressed;
  final IconSize size;
  final BoxShape shape;
  final bool hasBorder;
  final bool isFilledColor;
  final bool isSelected;

  const SyntonicIcon({
    Key? key,
    required this.icon,
    this.color,
    this.padding = 16,
    this.onPressed,
    this.size = IconSize.small,
    this.shape = BoxShape.circle,
    this.hasBorder = false,
    this.isFilledColor = false,
    this.isSelected = false,
  }) : super(key: key);

  const SyntonicIcon.filled({
    Key? key,
    required this.icon,
    this.color,
    this.padding = 16,
    this.onPressed,
    this.size = IconSize.small,
    this.shape = BoxShape.circle,
    this.hasBorder = false,
    this.isSelected = false,
  })  : isFilledColor = true,
        super(key: key);

  const SyntonicIcon.tonal({
    Key? key,
    required this.icon,
    this.color,
    this.padding = 16,
    this.onPressed,
    this.size = IconSize.small,
    this.shape = BoxShape.circle,
    this.hasBorder = false,
    this.isSelected = false,
  })  : isFilledColor = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Theme(
        data: _isDarkTheme ? darkTheme() : lightTheme(),
        child: RepaintBoundary(
          child: InkWell(
            onTap: onPressed,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected)
                  Container(
                    width: size.size! + 6, // Slightly larger than the icon
                    height: size.size! + 6,
                    decoration: BoxDecoration(
                      shape: shape,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 1,
                      ),
                    ),
                  ),
                Container(
                  width: size.size,
                  height: size.size,
                  decoration: BoxDecoration(
                    color: hasBorder
                        ? (isFilledColor ? Theme.of(context).colorScheme.surface : null)
                        : color,
                    borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(21),
                    shape: shape,
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: isFilledColor ? Colors.white : (color ?? Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
