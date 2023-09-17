import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicBottomSheet extends StatelessWidget {
  static const routeName = 'Karute';
  Widget widget;

  SyntonicBottomSheet({required this.widget});

  @override
  Widget build(BuildContext context) {
    return   BottomSheet(
      elevation: 10,
      backgroundColor: (MediaQuery.of(context).platformBrightness ==
          Brightness.light) ? Colors.white : SyntonicColor.black56,
      onClosing: () {
        // Do something
      },
      builder: (BuildContext ctx) =>
      this.widget,
    );
  }
}