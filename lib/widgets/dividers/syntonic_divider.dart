import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/material.dart';

enum DividerType {
  vertical,
  horizontal,
}

class SyntonicDivider extends StatelessWidget {
  /// Whether the divider is bold.
  final bool isBold;

  /// A fixed value depending on [isBold].
  late final double? _thickness;

  final DividerType type;

  SyntonicDivider({this.isBold = false, this.type = DividerType.horizontal}) {
    _thickness = isBold ? 8 : 0.5;
  }

  SyntonicDivider.bold() : this(isBold: true);

  SyntonicDivider.vertical() : this(type: DividerType.vertical);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case DividerType.vertical:
        return VerticalDivider(color: SyntonicColor().divider,);
      case DividerType.horizontal:
        return Divider(
          thickness: _thickness,
          color: isBold ? SyntonicColor().backgroundFilled : SyntonicColor()
              .divider,
        );
    }
  }
}

