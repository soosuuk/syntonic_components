import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/themes/syntonic_dark_theme.dart';
import '../../configs/themes/syntonic_light_theme.dart';

class SyntonicCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? image;
  final Widget? child;
  final double? elevation;
  final Color? color;
  final bool needsBorder;
  final bool hasPadding;
  final double borderRadius;

  const SyntonicCard(
      {
        this.borderRadius = 12,
        this.onTap,
      this.isSelected = false,
        this.image,
      this.child,
      this.elevation,
      this.color,
        this.needsBorder = false,
      this.hasPadding = true});

  const SyntonicCard.transparent(
      {VoidCallback? onTap, bool isSelected = false, Widget? child, bool hasPadding = true})
      : this(
            onTap: onTap,
            isSelected: isSelected,
            child: child,
            elevation: 0,
            needsBorder: false,
            hasPadding: hasPadding,
            color: Colors.transparent);

  const SyntonicCard.outlined(
      {VoidCallback? onTap, bool isSelected = false, Widget? child, bool hasPadding = true})
      : this(
      onTap: onTap,
      isSelected: isSelected,
      child: child,
      elevation: 0,
      needsBorder: true,
      hasPadding: hasPadding,
      color: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Theme(data: color != null ? isDarkTheme ? darkTheme(primaryColor: color) : lightTheme(primaryColor: color) : Theme.of(context), child: Card(
      // color: null,
      // surfaceTintColor: colorScheme != null ? colorScheme!.surfaceTint : null,
      // shadowColor: colorScheme != null ? colorScheme!.shadow : null,
      elevation: elevation,
      // color: isSelected ? Theme.of(context).colorScheme.primary.toAlpha : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Column(children: [image ?? const SizedBox(), Container(
          decoration: needsBorder ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: 1, color: Theme.of(context).colorScheme.outlineVariant)
          ) : null,
          padding: const EdgeInsets.all(16),
          child: child,
        )],),
      ),
    ));
  }
}
