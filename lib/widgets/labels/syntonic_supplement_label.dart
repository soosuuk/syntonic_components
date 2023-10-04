import 'package:drift/drift.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SyntonicSupplementLabel extends StatelessWidget {
  @required
  final String text;
  late Color? color;
  final bool isFilled;
  final bool hasPadding;

  SyntonicSupplementLabel({
    required this.text,
    this.color,
    this.isFilled = true,
    this.hasPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: hasPadding ? EdgeInsets.all(16) : EdgeInsets.all(0), child: Container(
      height: 40,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Body2Text(text: text),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.secondaryContainer),
    ),);
  }
}
