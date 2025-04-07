import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

/// Flexible Grid view (height of grid item depends on content of grid item).
class SyntonicGridView extends ListItem {
  final Widget Function(int index)? itemBuilder;
  final int itemCount;
  final int crossAxisCount;
  final bool needsBackgroundColorFilled;
  final bool hasPadding;
  final String overLineText;

  const SyntonicGridView({
    required this.itemBuilder,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.needsBackgroundColorFilled = false,
    this.hasPadding = true,
    this.overLineText = '',
  });

  @override
  Widget build(BuildContext context) {
    final int columnCount = (itemCount / crossAxisCount).ceil();
    List<Widget> rows = [];

    for (int i = 0; i < columnCount; i++) {
      bool hasRemainder = (i * crossAxisCount + 1) >= itemCount;
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(child: itemBuilder!(i * crossAxisCount)),
        const SizedBox(width: 8),
        hasRemainder
            ? const Flexible(child: SizedBox(width: 0))
            : Flexible(child: itemBuilder!(i * crossAxisCount + 1))
      ]));
      rows.add(const SizedBox(height: 16));
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: (hasPadding) ? 16 : 0),
        child: Column(children: rows));
  }
}
