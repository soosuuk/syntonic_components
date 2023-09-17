import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicRadioButton extends StatelessWidget {
  final BuildContext context;
  final int groupValue;
  final int value;
  final Function(int value) onChanged;

  const SyntonicRadioButton({required this.context, required this.groupValue, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: value,
      groupValue: groupValue,
      onChanged: (valu) {
        onChanged(value);
      },
    );
  }
}