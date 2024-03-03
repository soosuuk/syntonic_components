import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';

class SyntonicInputChip extends StatelessWidget {
  final int index;
  final String label;
  final Function(int index)? onDeleted;
  final Widget? icon;

  const SyntonicInputChip(
      {required this.index,
      required this.label,
      required this.onDeleted,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.toAlpha,
      // shape: StadiumBorder(side: BorderSide(width: 0, color: Colors.transparent)),
      onDeleted: onDeleted != null
          ? () {
              onDeleted!(index);
            }
          : null,
      deleteIconColor: Theme.of(context).colorScheme.primary,
      avatar: icon,
    );
  }
}
