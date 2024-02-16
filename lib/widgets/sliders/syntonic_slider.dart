import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../texts/body_1_text.dart';

class SyntonicSlider extends StatefulWidget {
  final String label;
  final double value;
  final Function(double) onChangeEnd;
  final EdgeInsets? padding;
  const SyntonicSlider({Key? key, required this.label, required this.value, required this.onChangeEnd, this.padding}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SyntonicSliderState();

}

class _SyntonicSliderState extends State<SyntonicSlider> {
  double _value = 60;

  _SyntonicSliderState();

  @override
  initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [
      Body1Text(text: (_value / 60).toString()),
      Expanded(child: Slider(label: (_value / 60).toString(),
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        onChangeEnd: widget.onChangeEnd,
        max: 30*12,
        min: 0,
        divisions: 30*12 ~/ 30,))
    ],),);
  }
}