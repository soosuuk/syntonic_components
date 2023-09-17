import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyntonicToggleButtons extends StatelessWidget {
  final List<String> buttonNames;
  final Function(int index) onToggleButtonPressed;
  late List<bool> selectedStates = [];
  int? initialSelectedIndex = 0;

  SyntonicToggleButtons({required this.buttonNames, required this.onToggleButtonPressed, this.initialSelectedIndex}) {

    // Create list that whether a button is selecting.
    for (int i = 0; i < buttonNames.length; i++) {
      if (initialSelectedIndex != null) {
        selectedStates.add(i == initialSelectedIndex ? true : false);
      } else {
        selectedStates.add(i == 0 ? true : false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => SyntonicToggleButtonsManager(selectedStates: this.selectedStates),
      child: Consumer<SyntonicToggleButtonsManager>(
        builder: (context, model, child) {
          return LayoutBuilder(
              builder: (context, constraints) => ToggleButtons(
                  constraints: BoxConstraints.expand(width: constraints.maxWidth/buttonNames.length - 4),
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(4),
                  children: getButtonTexts(),
                  onPressed: (int index) {
                    model.changeSelection(index);
                    onToggleButtonPressed(index);
                  },
                  isSelected: model.selectedStates,
              )
          );
        }, // a
      ),
    );
  }

  /// Get button texts.
  List<Widget> getButtonTexts() {
    List<Widget> buttonTexts = [];
    for (int i = 0; i < this.buttonNames.length; i++) {
      buttonTexts.add(Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          this.buttonNames[i],
        ),
      ));
    }
    return buttonTexts;
  }
}

class SyntonicToggleButtonsManager extends ChangeNotifier {
  List<bool> selectedStates;

  SyntonicToggleButtonsManager({required this.selectedStates});

  /// Change selection.
  void changeSelection(int index) {
      for (int i = 0; i < selectedStates.length; i++) {
        selectedStates[i] = i == index;
      }
    notifyListeners();
  }
}