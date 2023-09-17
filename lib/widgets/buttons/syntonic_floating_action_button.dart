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

  SyntonicFloatingActionButton(
      {required this.isExtended,
      required this.floatingActionButtonModel,
      this.isSecondary = false,
      this.heroTag = '',
      this.width});

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkTheme = brightness == Brightness.dark;

    return Container(
      width: width,
      height: this.isExtended ? 56 : 48,
      child: SizedBox(
        child: FloatingActionButton.extended(
            backgroundColor:
                this.isSecondary ? Theme.of(context).colorScheme.surface : null,
            isExtended: true,
            extendedPadding:
                this.isExtended ? SyntonicConstraint.horizontal16 : null,
            onPressed: floatingActionButtonModel.onTap,
            heroTag: floatingActionButtonModel.heroTag,
            label: AnimatedSwitcher(
              duration: Duration(milliseconds: 180),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  child: child,
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                ),
              ),
              child: this.isExtended
                  ? Icon(this.floatingActionButtonModel.icon ?? Icons.add,
                      color: this.isSecondary
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primary.getColorByLuminance)
                  : Row(
                      key: UniqueKey(),
                      children: [
                        Padding(
                          padding: SyntonicConstraint.trailing8,
                          child: Icon(
                            this.floatingActionButtonModel.icon ?? Icons.add,
                            color: this.isSecondary
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary.getColorByLuminance,
                          ),
                        ),
                        Subtitle2Text(
                          text: this.floatingActionButtonModel.text,
                          textColor: this.isSecondary
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary.getColorByLuminance,
                          needsLinkify: false,
                        )
                      ],
                    ),
            )),
      ),
    );
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
