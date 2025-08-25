import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/enhancers/syntonic_gradient_container.dart';

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
      {this.borderRadius = 0,
      this.onTap,
      this.isSelected = false,
      this.image,
      this.child,
      this.elevation,
      this.colorScheme,
      this.needsBorder = false,
      this.hasMargin = true,
      this.hasPadding = true,
      this.imagePosition = ImagePosition.top,
      this.isGlassmorphismEnabled = false});

  const SyntonicCard.transparent({
    double borderRadius = 0,
    VoidCallback? onTap,
    bool isSelected = false,
    Widget? child,
    bool hasMargin = true,
    bool hasPadding = true,
    Widget? image,
    ImagePosition? imagePosition,
  }) : this(
          borderRadius: borderRadius,
          onTap: onTap,
          image: image,
          isSelected: isSelected,
          child: child,
          elevation: 0,
          needsBorder: false,
          hasPadding: hasPadding,
          imagePosition: imagePosition ?? ImagePosition.top,
        );

  const SyntonicCard.outlined({
    double borderRadius = 0,
    VoidCallback? onTap,
    bool isSelected = false,
    Widget? child,
    bool hasMargin = true,
    bool hasPadding = true,
    Widget? image,
    ImagePosition? imagePosition,
  }) : this(
          borderRadius: borderRadius,
          onTap: onTap,
          isSelected: isSelected,
          image: image,
          child: child,
          elevation: 0,
          needsBorder: true,
          hasMargin: hasMargin,
          hasPadding: hasPadding,
          imagePosition: imagePosition ?? ImagePosition.top,
        );

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget _card = Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      // color: isGlassmorphismEnabled ? Colors.transparent : null,
      // color: colorScheme != null ? colorScheme!.surface : Theme.of(context).colorScheme.surfaceBright,
      color: colorScheme != null ? colorScheme!.surface : Colors.transparent,
      surfaceTintColor: colorScheme?.surfaceTint,
      // shadowColor: colorScheme != null ? Colors.transparent : null,
      shadowColor: Colors.transparent,
      elevation: elevation,
      // color: isSelected ? Theme.of(context).colorScheme.primary.toAlpha : color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // clipBehavior: Clip.antiAlias,
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
          child: Padding(
            padding: hasPadding
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                : EdgeInsets.zero,
            child: _card,
          ));
    } else {
      return _card;
    }
  }

  Widget _childWithImage({required BuildContext context}) {
    Widget _child = Padding(
        padding: EdgeInsets.zero,
        // padding: hasMargin ? EdgeInsets.all(16) : EdgeInsets.zero,
        child: Container(
          decoration: needsBorder
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.outlineVariant))
              : null,
          // padding: const EdgeInsets.only(right: 16),
          child: Padding(
            padding: hasPadding ? const EdgeInsets.all(16) : EdgeInsets.zero,
            child: Row(
              children: [Expanded(child: child!)],
            ),
          ),
        ));

    if (image == null) {
      return isGlassmorphismEnabled
          ? Container(
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
              ),
            )
          : _child;
    }

    switch (imagePosition) {
      case ImagePosition.left:
      case ImagePosition.right:
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              imagePosition == ImagePosition.left ? image! : const SizedBox(),
              Flexible(child: _child),
              imagePosition == ImagePosition.right ? image! : const SizedBox(),
            ],
          ),
        );
      case ImagePosition.top:
      case ImagePosition.bottom:
        return Column(
          children: [
            imagePosition == ImagePosition.top
                ? SizedBox(
                    height: 150,
                    child: image!,
                  )
                : const SizedBox(),
            _child,
            imagePosition == ImagePosition.bottom ? image! : const SizedBox(),
          ],
        );
      case ImagePosition.spread:
        return IntrinsicHeight(
          child: Stack(
            children: [
              Positioned.fill(
                  child: SyntonicGradientContainer(
                color: [
                  Colors.black.withAlpha(50),
                  Colors.transparent,
                ],
                startAt: GradientStartPosition.bottom,
                child: image!,
              )),
              isGlassmorphismEnabled
                  ? ClipRRect(
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
                    )
                  : Theme(
                      data: darkTheme(colorScheme: colorScheme),
                      child: _child,
                    )
            ],
          ),
        );
      // return Stack(children: [image!, _child],);
    }
  }
}
