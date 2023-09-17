import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/syntonic_color.dart';

/// Check icon.
class SyntonicCheckIcon extends StatelessWidget {
  /// Color.
  final Color? color;

  /// Size.
  final IconSize? type;

  /// Whether a [CheckIcon] needs padding.
  final bool hasPadding;

  /// Whether a [CheckIcon] is checked.
  final bool isChecked;

  /// Height.
  final double? height;

  /// Width.
  final double? width;

  const SyntonicCheckIcon(
      {this.color,
      this.type = IconSize.normal,
      this.hasPadding = true,
      this.isChecked = false,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(hasPadding ? 16 : 0),
      child: Container(
        height: height ?? type!.size!,
        width: width ?? type!.size!,
        child: Material(
          color: color ??
              (isChecked
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white),
          shape: CircleBorder(
            side: BorderSide(width: 2, color: SyntonicColor().divider),
          ),
          child: Padding(
            padding: EdgeInsets.all(1),
            child: FittedBox(
              child: Icon(
                Icons.check,
                color: isChecked ? Colors.white : SyntonicColor.black40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
