import 'package:flutter/material.dart';

class SyntonicExpandableListView extends StatelessWidget {
  final int index;
  final Widget headline;
  final List<Widget>? listItems;

  const SyntonicExpandableListView(
      {required this.index, required this.headline, this.listItems});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
        // tileColor:
        //     (MediaQuery.of(context).platformBrightness == Brightness.light)
        //         ? SyntonicColor.concrete
        //         : SyntonicColor.black56,
        child: ExpansionTile(
            // childrenにTextFormFieldがある場合、スクロールエラーを無くすため、入力状態を保つためにこの属性が必要
            maintainState: true,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            key: PageStorageKey(index),
            title: headline,
            children: listItems ?? []));
  }
}

// class Menu {
//   String menuTitle;
//   List<MenuInfo> menuInfo;
//
//   Menu(this.menuTitle, this.menuInfo);
// }
//
// class MenuInfo {}
