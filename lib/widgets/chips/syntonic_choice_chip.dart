import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

import '../texts/body_1_text.dart';

class SyntonicChoiceChip extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final Function(bool isSelected) onSelected;
  final Color? color;
  final bool hasPadding;

  @Deprecated("You should use [trailingIcon] instead of this.")
  final IconData? icon;

  final Widget? trailingIcon;

  const SyntonicChoiceChip(
      {required this.index,
      required this.label,
      required this.isSelected,
      required this.onSelected,
      this.color,
      this.icon,
      this.trailingIcon, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Padding(padding: hasPadding ? EdgeInsets.only(left: index == 0 ? 16 : 4, top: 16) : EdgeInsets.zero, child: FilterChip(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        labelPadding: EdgeInsets.zero,
        // shape: StadiumBorder(
        //     side: BorderSide(
        //       width: 1,
        //       color: Colors.redAccent,
        //     )),

        label: SizedBox(
          // width: double.infinity,
          child: Body2Text(
            text: label,
            textColor: isSelected
                ? Theme.of(context).colorScheme.primary
                : isDarkTheme
                ? Colors.white70
                : SyntonicColor.black88,),
        ),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary.toAlpha
            : Colors.transparent,
        // shape: StadiumBorder(
        //     side: BorderSide(
        //         width: 0.5,
        //         color: isSelected
        //             ? Theme.of(context).colorScheme.primary
        //             : isDarkTheme
        //                 ? Colors.white60
        //                 : SyntonicColor.black40)),
        selectedColor: Theme.of(context).colorScheme.primary.toAlpha,
        selected: isSelected,
        onSelected: (bool isSelected) {
          onSelected(isSelected);
        },
        avatar: trailingIcon ??
            (icon != null
                ? Icon(icon,
                color: color ??
                    (isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary))
                : null),
        showCheckmark: icon != null || trailingIcon != null ? false : true,
        checkmarkColor: Theme.of(context).colorScheme.primary),);
  }
}
