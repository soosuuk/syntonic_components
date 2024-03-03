import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';

class LinearDotsList extends StatelessWidget {
  const LinearDotsList({
    Key? key,
    required this.children,
    this.color,
  }) : super(key: key);

  final List<Widget> children;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    for (int i = 0; i < children.length; i++) {
      _children.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          children[i],
          children.length - 1 != i
              ? Body2Text(
                  text: '・',
                  textColor: color,
                )
              : const SizedBox()
        ],
      ));
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _children,
    );
  }
}
