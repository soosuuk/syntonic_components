import 'package:flutter/material.dart';

import '../../configs/themes/syntonic_dark_theme.dart';
import '../../configs/themes/syntonic_light_theme.dart';

enum ImagePosition {
  left,
  top,
  right,
  bottom,
}

class SyntonicCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? image;
  final Widget? child;
  final double? elevation;
  final ColorScheme? colorScheme;
  final bool needsBorder;
  final bool hasPadding;
  final double borderRadius;
  final ImagePosition imagePosition;

  const SyntonicCard(
      {this.borderRadius = 24,
      this.onTap,
      this.isSelected = false,
      this.image,
      this.child,
      this.elevation,
      this.colorScheme,
      this.needsBorder = false,
      this.hasPadding = true,
      this.imagePosition = ImagePosition.top});

  const SyntonicCard.transparent(
      {VoidCallback? onTap,
      bool isSelected = false,
      Widget? child,
      bool hasPadding = true,
      Widget? image})
      : this(
            onTap: onTap,
            image: image,
            isSelected: isSelected,
            child: child,
            elevation: 0,
            needsBorder: false,
            hasPadding: hasPadding,
      );

  const SyntonicCard.outlined(
      {VoidCallback? onTap,
      bool isSelected = false,
      Widget? child,
      bool hasPadding = true,
      Widget? image})
      : this(
            onTap: onTap,
            isSelected: isSelected,
            image: image,
            child: child,
            elevation: 0,
            needsBorder: true,
            hasPadding: hasPadding,
      );

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget _card = Card(
      margin: EdgeInsets.zero,
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
        child: _childWithImage(context: context),
      ),
    );

    if (colorScheme != null) {
      return Theme(
          data: colorScheme != null
              ? isDarkTheme
                  ? darkTheme(colorScheme: colorScheme)
                  : lightTheme(colorScheme: colorScheme)
              : Theme.of(context),
          child: _card);
    } else {
      return _card;
    }
  }

  Widget _childWithImage({required BuildContext context}) {
    Widget _child = Container(
      decoration: needsBorder
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant))
          : null,
      padding: const EdgeInsets.all(16),
      child: child,
    );

    if (image == null) {
      return _child;
    }

    switch (imagePosition) {
      case ImagePosition.left:
      case ImagePosition.right:
        return IntrinsicHeight(child: Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imagePosition == ImagePosition.left ? image! : const SizedBox(),
            Flexible(child: _child),
            imagePosition == ImagePosition.right ? image! : const SizedBox(),
          ],
        ),);
      case ImagePosition.top:
      case ImagePosition.bottom:
        return Column(
          children: [
            imagePosition == ImagePosition.top ? image! : const SizedBox(),
            _child,
            imagePosition == ImagePosition.bottom ? image! : const SizedBox(),
          ],
        );
    }
  }
}
