import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
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
          TextButton(
            onPressed: () {
              widget.onSelected(_selectedDuration);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}