import 'package:dynamic_color/dynamic_color.dart';
import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
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

  SyntonicCard(
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

  SyntonicCard.transparent(
      {VoidCallback? onTap, bool isSelected = false, Widget? child, bool hasPadding = true})
      : this(
            onTap: onTap,
            isSelected: isSelected,
            child: child,
            elevation: 0,
            needsBorder: false,
            hasPadding: hasPadding,
            color: Colors.transparent);

  SyntonicCard.outlined(
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
    return Theme(data: color != null ? darkTheme(primaryColor: color) : Theme.of(context), child: Card(
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
        child: Column(children: [image ?? SizedBox(), Container(
          decoration: needsBorder ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: 1, color: Theme.of(context).colorScheme.outlineVariant)
          ) : null,
          padding: const EdgeInsets.all(16),
          child: child,
        )],),
      ),
    ));

    return Card(
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
        child: Container(
          decoration: needsBorder ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: 1, color: Theme.of(context).colorScheme.outlineVariant)
          ) : null,
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: child,
        ),
      ),
    );
  }
}
