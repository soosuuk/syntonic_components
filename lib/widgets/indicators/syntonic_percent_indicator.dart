import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SyntonicPercentIndicator extends StatelessWidget {
  /// Percent.
  final double percent;

  const SyntonicPercentIndicator._({
    required this.percent,
  });

  /// Circle.
  const SyntonicPercentIndicator.circle({
    required double percent,
  }) : this._(percent: percent);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 10.0,
      lineWidth: 4.0,
      percent: percent > 1 ? 1 : percent,
      progressColor: Theme.of(context).colorScheme.primary,
      backgroundColor: SyntonicColor().divider,
    );
  }
}
