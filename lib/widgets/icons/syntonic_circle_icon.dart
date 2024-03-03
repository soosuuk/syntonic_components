import 'package:flutter/material.dart';

class SyntonicCircleIcon extends StatelessWidget {
  final Icon icon;
  final Color color;

  const SyntonicCircleIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: color,
        radius: 12,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: icon,
          iconSize: 16,
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
