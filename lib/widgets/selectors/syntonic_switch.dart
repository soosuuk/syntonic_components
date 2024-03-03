import 'package:flutter/material.dart';

class SyntonicSwitch extends StatelessWidget {
  final bool isSwitchedOn;
  final Function(bool? isSwitchedOn) onSwitchStateChanged;

  const SyntonicSwitch(
      {required this.isSwitchedOn, required this.onSwitchStateChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Switch(
          value: isSwitchedOn,
          onChanged: (value) {
            onSwitchStateChanged(value);
          },
        ));
  }
}
