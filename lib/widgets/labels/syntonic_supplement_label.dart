import 'package:drift/drift.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SyntonicSupplementLabel extends StatelessWidget {
  @required
  final String text;
  final Color? color;
  final bool isFilled;
  final bool hasPadding;

  const SyntonicSupplementLabel({Key? key,
    required this.text,
    this.color,
    this.isFilled = true,
    this.hasPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: hasPadding ? const EdgeInsets.all(16) : const EdgeInsets.all(0), child: Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Body2Text(text: text),
        ),
      ),
    ),);
  }
}
