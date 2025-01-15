import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../buttons/syntonic_button.dart';

class SyntonicDurationPicker extends StatefulWidget {
  final void Function(Duration) onSelected;
  final Duration initialDuration;

  const SyntonicDurationPicker({
    Key? key,
    required this.onSelected,
    this.initialDuration = const Duration(hours: 0, minutes: 0),
  }) : super(key: key);

  @override
  _SyntonicDurationPickerState createState() => _SyntonicDurationPickerState();
}

class _SyntonicDurationPickerState extends State<SyntonicDurationPicker> {
  late Duration _selectedDuration;

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.initialDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: EdgeInsets.only(top: 12, left: 16, right: 16),child: SyntonicButton.transparent(onTap: () {
            widget.onSelected(_selectedDuration);
            Navigator.pop(context);
            // actionAddingViewModel.pageController.jumpToPage(0);
          }, text: 'Done'),),],),
          Expanded(
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: _selectedDuration,
              minuteInterval: 10, // 10分刻みで選択
              onTimerDurationChanged: (Duration newDuration) {
                setState(() {
                  _selectedDuration = newDuration;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}