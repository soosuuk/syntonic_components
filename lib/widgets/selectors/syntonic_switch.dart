import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicSwitch extends StatelessWidget {
  final bool isSwitchedOn;
  final Function(bool? isSwitchedOn) onSwitchStateChanged;

  SyntonicSwitch({required this.isSwitchedOn, required this.onSwitchStateChanged});

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(left: 8, right: 8), child: Switch(
      value: isSwitchedOn,
      onChanged: (value) {
        onSwitchStateChanged(value);
      },
    ));
  }
}