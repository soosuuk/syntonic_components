import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicIcon extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double padding;

  SyntonicIcon({required this.icon, this.color, this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: Icon(icon,
          color: (color ?? ((MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? SyntonicColor.black72
                  : Colors.white
            )
          )
      )
    );
  }
}
