import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';

class LinearDotsList extends StatelessWidget {
  const LinearDotsList({Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = children.map((widget) => Row(children: [widget, const Body2Text(text: '・')],)).toList();
    return Wrap(children: _children,);
  }
}