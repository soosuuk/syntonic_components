import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SyntonicStepper extends StatelessWidget {
  List<String> stepTitles = [];

  SyntonicStepper({required this.stepTitles});

  @override
  Widget build(BuildContext context) {
    return Stepper(
        key: Key(Random.secure().nextDouble().toString()),
        type: StepperType.vertical,
        physics: const NeverScrollableScrollPhysics(),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        controlsBuilder: (BuildContext context, ControlsDetails detail) {
          return Container();
        },
        steps: getSteps());
  }

  List<Step> getSteps() {
    List<Step> steps = [];
    for (int j = 0; j < stepTitles.length; j++) {
      steps.add(Step(
        state: StepState.disabled,
        title: Text(stepTitles[j]),
        content: Container(),
        isActive: true,
      ));
    }
    return steps;
  }
}
