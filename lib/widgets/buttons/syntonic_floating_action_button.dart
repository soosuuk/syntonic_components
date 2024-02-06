import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/configs/constants/syntonic_constraint.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
      {Key? key, required this.isExtended,
      required this.floatingActionButtonModel,
      this.isSecondary = false,
      this.heroTag = '',
      this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // bool isDarkTheme = brightness == Brightness.dark;

    if (isSecondary) {
      return FloatingActionButton.small(backgroundColor: Theme.of(context).colorScheme.secondaryContainer, onPressed: floatingActionButtonModel.onTap, child: Icon(this.floatingActionButtonModel.icon ?? Icons.add),);
    } else {
      return SizedBox(
        width: width,
        height: 56,
        child: FloatingActionButton.extended(
            backgroundColor:
            this.isSecondary ? Theme.of(context).colorScheme.surface : null,
            isExtended: true,
            extendedPadding:
            !this.isExtended ? SyntonicConstraint.horizontal16 : null,
            onPressed: floatingActionButtonModel.onTap,
            heroTag: floatingActionButtonModel.heroTag,
            label: AnimatedSwitcher(
              duration: const Duration(milliseconds: 120),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      child: child,
                    ),
                  ),
              child: !this.isExtended
                  ? Icon(this.floatingActionButtonModel.icon ?? Icons.add,
                  color: this.isSecondary
                      ? Theme.of(context).colorScheme.onSurface
                      : null)
                  : Row(
                key: UniqueKey(),
                children: [
                  Padding(
                    padding: SyntonicConstraint.trailing8,
                    child: Icon(
                      this.floatingActionButtonModel.icon ?? Icons.add,
                      color: this.isSecondary
                          ? Theme.of(context).colorScheme.onSurface
                          : null,
                    ),
                  ),
                  Subtitle2Text(
                    text: this.floatingActionButtonModel.text,
                    textColor: this.isSecondary
                        ? Theme.of(context).colorScheme.onSurface
                        : null,
                    needsLinkify: false,
                  )
                ],
              ),
            )),
      );
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
