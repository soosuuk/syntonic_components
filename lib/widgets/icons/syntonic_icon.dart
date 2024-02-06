import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/themes/syntonic_dark_theme.dart';

class SyntonicIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double padding;
  final VoidCallback? onPressed;

  const SyntonicIcon({Key? key, required this.icon, this.color, this.padding = 16, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(padding), child: Theme(data: darkTheme(primaryColor: color), child: RepaintBoundary(child: IconButton(
        icon: Icon(icon, size: 16,),
        iconSize: 18,
        padding: EdgeInsets.all(4),
        constraints: const BoxConstraints(),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          disabledBackgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          hoverColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
          focusColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
          highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
        )),)),);
  }
}
