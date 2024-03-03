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

  final bool hasDotted;

  final Color? color;

  final double? height;

  SyntonicDivider(
      {this.isBold = false,
      this.type = DividerType.horizontal,
      this.hasDotted = false,
      this.color,
      this.height}) {
    _thickness = isBold ? 8 : 0.5;
  }

  SyntonicDivider.bold() : this(isBold: true);

  SyntonicDivider.vertical(
      {Color? color, bool hasDotted = false, double? height})
      : this(
            type: DividerType.vertical,
            color: color,
            hasDotted: hasDotted,
            height: height);

  @override
  Widget build(BuildContext context) {
    if (hasDotted) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double lineWidth = constraints.maxWidth; // Dividerの横幅
          const double dashWidth = 4.0; // 点線の幅
          const double dashSpace = 2.0; // 線と線の間隔

          // 点線の個数を計算
          int dashCount = (lineWidth / (dashWidth + dashSpace)).floor();

          return SizedBox(
            width: lineWidth,
            height: 1.0, // Dividerの高さ
            child: ListView.builder(
              itemCount: dashCount,
              scrollDirection: type == DividerType.horizontal
                  ? Axis.horizontal
                  : Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                // 各点線の描画
                return Container(
                  width: dashWidth,
                  height: 1.0, // 点線の高さ
                  color: color ??
                      Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.38), // 点線の色
                  margin: const EdgeInsets.symmetric(horizontal: dashSpace),
                );
              },
            ),
          );
        },
      );
    }

    switch (type) {
      case DividerType.vertical:
        return height != null
            ? Container(
                height: height,
                width: 1,
                color: color ?? SyntonicColor().divider,
              )
            : Container(
                width: 1,
                color: color ?? SyntonicColor().divider,
              );
      case DividerType.horizontal:
        return Divider(
          thickness: _thickness,
          color: color ??
              (isBold
                  ? SyntonicColor().backgroundFilled
                  : SyntonicColor().divider),
        );
    }
  }
}
