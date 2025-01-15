import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_button.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/headline_5_text.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';

import '../texts/body_1_text.dart';

class SyntonicDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final Widget? contentWidget;
  final List<SyntonicDialogButtonInfoModel> buttonInfoList;

  const SyntonicDialog(
      {Key? key,
      this.title,
      this.content,
      this.contentWidget,
      required this.buttonInfoList})
      : super(key: key);

  List<Widget> _prepareButtons(
      List<SyntonicDialogButtonInfoModel> buttonInfoList,
      BuildContext context) {
    List<Widget> widgetList = [];

    // 3 個以上の場合、縦並びで表示するため
    if (buttonInfoList.length >= 3) {
      Widget tempWidget = Column(
        children: [
          for (final buttonItem in buttonInfoList) ...[
            SyntonicButton.transparent(
              onTap: () => {
                buttonItem.buttonAction(), // 呼び出し側で指定されたActionを実行する
                Navigator.of(context).pop()
              },
              text: buttonItem.buttonTxt,
            ),
          ]
        ],
      );

      widgetList.add(tempWidget);
    } else {
      // 2 個以下の場合、横並びで表示するため

      if (buttonInfoList.isNotEmpty) {
        for (int i = 0; i < buttonInfoList.length; i++) {
          final buttonItem = buttonInfoList[i];
          widgetList.add(
            i == 1
                ? SyntonicButton.filled(
              padding: EdgeInsets.zero,
              onTap: () => {
                buttonItem.buttonAction(), // Execute the action specified by the caller
                Navigator.of(context).pop()
              },
              text: buttonItem.buttonTxt,
            )
                : SyntonicButton.outlined(
              padding: EdgeInsets.zero,
              onTap: () => {
                buttonItem.buttonAction(), // Execute the action specified by the caller
                Navigator.of(context).pop()
              },
              text: buttonItem.buttonTxt,
            ),
          );
        }
      }
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
      ),
      title: (title != null) ? Headline6Text(text: title ?? "") : null,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            if (content != null) Body1Text(text: content ?? ""),
            contentWidget ?? Container()
          ],
        ),
      ),
      actions: _prepareButtons(buttonInfoList, context),
    );
  }

  /// Dismissed dialog.
  static Future<void> show({
    required BuildContext context,
    required Widget Function(
      BuildContext context,
    ) builder,
  }) async {
    await showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (_context) {
        return builder(_context);
      },
    );
  }
}

class SyntonicDialogButtonInfoModel {
  final String buttonTxt;
  final Function buttonAction;

  SyntonicDialogButtonInfoModel(
      {required this.buttonTxt, required this.buttonAction});
}
