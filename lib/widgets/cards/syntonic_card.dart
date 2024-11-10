import 'dart:ui';

import 'package:flutter/material.dart';

import '../../configs/themes/syntonic_dark_theme.dart';
import '../../configs/themes/syntonic_light_theme.dart';

enum ImagePosition {
  left,
  top,
  right,
  bottom,
  spread,
}

class SyntonicCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? image;
  final Widget? child;
  final double? elevation;
  final ColorScheme? colorScheme;
  final bool needsBorder;
  final bool hasMargin;
  final bool hasPadding;
  final double borderRadius;
  final ImagePosition imagePosition;
  final bool isGlassmorphismEnabled;

  const SyntonicCard(
      {this.borderRadius = 16,
      this.onTap,
      this.isSelected = false,
      this.image,
      this.child,
      this.elevation,
      this.colorScheme,
      this.needsBorder = false,
        this.hasMargin = true,
      this.hasPadding = true,
      this.imagePosition = ImagePosition.top, this.isGlassmorphismEnabled = false});

  const SyntonicCard.transparent(
      {double borderRadius = 4,
        VoidCallback? onTap,
      bool isSelected = false,
      Widget? child, bool hasMargin = true,
      bool hasPadding = true,
      Widget? image})
      : this(
    borderRadius: borderRadius,
            onTap: onTap,
            image: image,
            isSelected: isSelected,
            child: child,
            elevation: 0,
            needsBorder: false,
            hasPadding: hasPadding,
      );

  const SyntonicCard.outlined(
      {
        double borderRadius = 4,
        VoidCallback? onTap,
      bool isSelected = false,
      Widget? child,
      bool hasMargin = true,
      bool hasPadding = true,
      Widget? image})
      : this(
    borderRadius: borderRadius,
            onTap: onTap,
            isSelected: isSelected,
            image: image,
            child: child,
            elevation: 0,
            needsBorder: true,
            hasMargin: hasMargin,
            hasPadding: hasPadding,
      );

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget _card = Card(
      // color: isGlassmorphismEnabled ? Colors.transparent : null,
      color: colorScheme != null ? colorScheme!.surface : Colors.transparent,
      surfaceTintColor: colorScheme != null ? colorScheme!.surfaceTint : null,
      shadowColor: colorScheme != null ? Colors.transparent : null,
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
        child: Padding(padding: hasMargin ? EdgeInsets.all(16) : EdgeInsets.zero, child: _childWithImage(context: context),),
      ),
    );

    if (colorScheme != null) {
      return Theme(
          data: colorScheme != null
              ? isDarkTheme
                  ? darkTheme(colorScheme: colorScheme)
                  : lightTheme(colorScheme: colorScheme)
              : Theme.of(context),
          child: Padding(padding: hasPadding ? EdgeInsets.symmetric(horizontal: 16, vertical: 8) : EdgeInsets.zero, child: _card,));
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
      padding: const EdgeInsets.only(right: 16),
      child: Padding(padding: hasPadding ? EdgeInsets.all(16) : EdgeInsets.zero, child: child,),
    );

    if (image == null) {
      return isGlassmorphismEnabled ? Container(
        decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 16,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          // 背景をぼかす
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Container(
            // height: 100,
            // width: width,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.12),
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: _child,
          ),
        ),
      ),) : _child;
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
      case ImagePosition.spread:
        return IntrinsicHeight(child: Stack(children: [Positioned.fill(child: image!), isGlassmorphismEnabled ? ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            // 背景をぼかす
            filter: ImageFilter.blur(
              sigmaX: 24,
              sigmaY: 24,
            ),
            child: Container(
              // height: 100,
              // width: width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: _child,
            ),
          ),
        ) : _child],),);
        // return Stack(children: [image!, _child],);
    }
  }
}
