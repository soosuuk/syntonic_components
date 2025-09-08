import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syntonic_components/configs/themes/syntonic_text_theme.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_1_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

class SyntonicToggleButtons extends StatelessWidget {
  final List<String> buttonNames;
  final Function(int index) onToggleButtonPressed;
  late List<bool> selectedStates = [];
  int? initialSelectedIndex = 0;

  SyntonicToggleButtons(
      {required this.buttonNames,
      required this.onToggleButtonPressed,
      this.initialSelectedIndex}) {
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
    EdgeInsets _padding = const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 0,
    );
    // EdgeInsets _padding = EdgeInsets.zero;
    return ListenableProvider(
      create: (context) =>
          SyntonicToggleButtonsManager(selectedStates: selectedStates),
      child: Consumer<SyntonicToggleButtonsManager>(
        builder: (context, model, child) {
          return LayoutBuilder(
              builder: (context, constraints) => Padding(
                  padding: _padding,
                  child: ToggleButtons(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // constraints: BoxConstraints.expand(
                    // width: constraints.maxWidth / buttonNames.length - _padding.horizontal,
                    //     height: 40),
                    selectedBorderColor: Theme.of(context).colorScheme.onSurface,
                    constraints: BoxConstraints.expand(
                        width: (constraints.maxWidth - 4) / 2, height: 44),
                    borderWidth: 1,
                    borderColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    borderRadius:
                        BorderRadius.circular(0), // Set rounded corners to 0
                    onPressed: (int index) {
                      model.changeSelection(index);
                      onToggleButtonPressed(index);
                    },
                    // textStyle: SyntonicTextTheme.caption(),
                    isSelected: model.selectedStates,
                    fillColor: Theme.of(context).colorScheme.onSurface,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant, // Set unselected color to black
                    selectedColor: Theme.of(context)
                        .colorScheme
                        .surface, // Set selected color to black
                    children: getButtonTexts(),
                  )));
        }, // a
      ),
    );
  }

  /// Get button texts.
  List<Widget> getButtonTexts() {
    List<Widget> buttonTexts = [];
    for (int i = 0; i < buttonNames.length; i++) {
      buttonTexts.add(IgnorePointer(child: Subtitle1Text(
        text: buttonNames[i],
      ),));
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
