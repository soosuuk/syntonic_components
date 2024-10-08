import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

/// Flexible Grid view (height of grid item depends on content of grid item).
class SyntonicGridView extends ListItem {
  @required
  final List<Widget> widgets;
  final int crossAxisCount = 2;
  final bool needsBackgroundColorFilled;
  final bool hasPadding;
  final String overLineText;

  const SyntonicGridView({
    required this.widgets,
    this.needsBackgroundColorFilled = false,
    this.hasPadding = true,
    this.overLineText = '',
  });

  @override
  Widget build(BuildContext context) {
    final int columnCount = (widgets.length / crossAxisCount).ceil();
    List<Widget> rows = [];
    List<Widget> widgetList = [...widgets];

    for (int i = 0; i < columnCount; i++) {
      bool hasRemainder = widgetList.length < 2;
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(child: widgetList[0]),
        SizedBox(width: 8),
        hasRemainder
            ? const Flexible(child: SizedBox(width: 0))
            : Flexible(child: widgetList[1])
      ]));
      hasRemainder
          ? widgetList.removeAt(0)
          : widgetList.removeRange(0, crossAxisCount);
      rows.add(const SizedBox(height: 16));
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: (hasPadding) ? 16 : 0),
        child: Column(children: rows));
  }
}
