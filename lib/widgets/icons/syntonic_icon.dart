import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/icons/syntonic_person_icon.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';

import '../../configs/themes/syntonic_dark_theme.dart';

class SyntonicIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double padding;
  final VoidCallback? onPressed;
  final IconSize? size;

  const SyntonicIcon({Key? key, required this.icon, this.color, this.padding = 16, this.onPressed, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _iconButton = Container(
      width: size != null ? size!.size : IconSize.small.size,
      height: size != null ? size!.size : IconSize.small.size,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
        // color: Colors.yellow,
        shape: BoxShape.circle,
      ),
      child: IconButton(
          icon: Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary,),
          // padding: EdgeInsets.all(4),
          // constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.onSurface.toAlpha,
            disabledBackgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
            hoverColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
            focusColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
            highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
          )),
    );
    return Padding(padding: EdgeInsets.all(padding), child: Theme(data: darkTheme(primaryColor: color), child: RepaintBoundary(child: _iconButton,)),);
  }
}
