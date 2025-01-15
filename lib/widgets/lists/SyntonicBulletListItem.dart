import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';

class SyntonicBulletListItem extends StatelessWidget {
  final String text;
  final Color? color;

  SyntonicBulletListItem({
    required this.text,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: CaptionText(text: text, textColor: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}