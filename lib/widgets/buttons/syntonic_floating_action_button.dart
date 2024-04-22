import 'package:syntonic_components/configs/constants/syntonic_constraint.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_1_text.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

class SyntonicFloatingActionButton extends StatelessWidget {
  /// The state of FAB is extend or not.
  @required
  final bool isExtended;

  /// Configuration data for FAB.
  @required
  final FloatingActionButtonModel floatingActionButtonModel;

  /// FAB is secondary or not.
  final bool isSecondary;

  /// When floating button multiple, use hero tag.
  final String heroTag;

  /// to define custom width.
  final double? width;

  const SyntonicFloatingActionButton(
      {Key? key,
      required this.isExtended,
      required this.floatingActionButtonModel,
      this.isSecondary = false,
      this.heroTag = '',
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // bool isDarkTheme = brightness == Brightness.dark;

    if (isSecondary) {
      return FloatingActionButton.small(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        onPressed: floatingActionButtonModel.onTap,
        child: Icon(
          floatingActionButtonModel.icon ?? Icons.add,
          color: Theme.of(context).colorScheme.primary,
          // size: 18,
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: 56,
        child: FloatingActionButton.extended(
            backgroundColor:
                isSecondary ? Theme.of(context).colorScheme.surface : null,
            isExtended: true,
            // extendedPadding:
            //     !isExtended ? SyntonicConstraint.horizontal16 : null,
            extendedIconLabelSpacing: isExtended ? 10 : 0,
            extendedPadding: isExtended ? null : const EdgeInsets.all(16),
            onPressed: floatingActionButtonModel.onTap,
            heroTag: floatingActionButtonModel.heroTag,
            // label: AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 120),
            //   transitionBuilder: (Widget child, Animation<double> animation) =>
            //       FadeTransition(
            //     opacity: animation,
            //     child: SizeTransition(
            //       sizeFactor: animation,
            //       axis: Axis.horizontal,
            //       child: child,
            //     ),
            //   ),
            //   child: !isExtended
            //       ? Icon(
            //           floatingActionButtonModel.icon ?? Icons.add,
            //           color: isSecondary
            //               ? Theme.of(context).colorScheme.primary
            //               : Theme.of(context).colorScheme.onPrimaryContainer,
            //           size: 18,
            //         )
            //       : Row(
            //           key: UniqueKey(),
            //           children: [
            //             Padding(
            //               padding: SyntonicConstraint.trailing8,
            //               child: Icon(
            //                 floatingActionButtonModel.icon ?? Icons.add,
            //                 color: isSecondary
            //                     ? Theme.of(context).colorScheme.primary
            //                     : Theme.of(context)
            //                         .colorScheme
            //                         .onPrimaryContainer,
            //                 size: 18,
            //               ),
            //             ),
            //             Subtitle1Text(
            //               text: floatingActionButtonModel.text,
            //               textColor: isSecondary
            //                   ? Theme.of(context).colorScheme.onSurface
            //                   : Theme.of(context)
            //                       .colorScheme
            //                       .onPrimaryContainer,
            //               needsLinkify: false,
            //             )
            //           ],
            //         ),
            // )
            icon: Icon(
              floatingActionButtonModel.icon ?? Icons.add,
              color: isSecondary
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer,
              size: 18,
            ),
            label: AnimatedSize(
        duration: const Duration(milliseconds: 120),
        child: isExtended ?  Subtitle2Text(
          text: floatingActionButtonModel.text,
          textColor: isSecondary
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context)
              .colorScheme
              .onPrimaryContainer,
          needsLinkify: false,
        ) : const SizedBox(),
      )));
    }
  }
}

class FloatingActionButtonModel {
  final VoidCallback onTap;
  final String text;
  final IconData? icon;
  final String heroTag;

  FloatingActionButtonModel(
      {required this.onTap,
      required this.text,
      this.icon = Icons.add,
      this.heroTag = ''});
}
