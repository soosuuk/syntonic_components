import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool? isChecked) onCheckStateChanged;

  SyntonicCheckbox({required this.isChecked, required this.onCheckStateChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        onCheckStateChanged(value);
      },
    );
  }
}