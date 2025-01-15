import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_button.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

class SyntonicBanner extends StatelessWidget {
  final Widget leading;
  final String message;
  final VoidCallback onTapped;
  final String actionText;

  const SyntonicBanner({
    Key? key,
    required this.leading,
    required this.message,
    required this.onTapped,
    required this.actionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading,
            SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Subtitle2Text(text: message, overflow: TextOverflow.visible,), SizedBox(height: 4,), SyntonicButton.transparent(isLined: true, onTap: () => onTapped(), text: actionText)],)),
          ],
        ),
      ),
    );
  }
}