import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';

class SyntonicChoiceChip extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final Function(bool isSelected) onSelected;
  final Color? color;

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
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return FilterChip(
        // shape: StadiumBorder(
        //     side: BorderSide(
        //       width: 1,
        //       color: Colors.redAccent,
        //     )),

        label: SizedBox(
          // width: double.infinity,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : isDarkTheme
                      ? Colors.white70
                      : SyntonicColor.black88,
            ),
          ),
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
        checkmarkColor: Theme.of(context).colorScheme.primary);
  }
}
