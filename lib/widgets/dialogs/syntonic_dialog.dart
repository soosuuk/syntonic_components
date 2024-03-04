import 'package:flutter/material.dart';

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
            TextButton(
              onPressed: () => {
                buttonItem.buttonAction(), // 呼び出し側で指定されたActionを実行する
                Navigator.of(context).pop()
              },
              child: Text(buttonItem.buttonTxt),
            ),
          ]
        ],
      );

      widgetList.add(tempWidget);
    } else {
      // 2 個以下の場合、横並びで表示するため

      if (buttonInfoList.isNotEmpty) {
        for (final buttonItem in buttonInfoList) {
          widgetList.add(
            TextButton(
              onPressed: () => {
                buttonItem.buttonAction(), // 呼び出し側で指定されたActionを実行する
                Navigator.of(context).pop()
              },
              child: Text(buttonItem.buttonTxt),
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
      title: (title != null) ? Text(title ?? "") : null,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            if (content != null) Text(content ?? ""),
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
