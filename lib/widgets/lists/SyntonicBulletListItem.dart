import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';

class SyntonicBulletListItem extends StatelessWidget {
  final String text;
  final Color? color;

  const SyntonicBulletListItem({
    required this.text,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Body2Text(
            text: text,
            // textColor: Theme.of(context).colorScheme.onSurfaceVariant
          ),
        ),
      ],
    );
  }
}
