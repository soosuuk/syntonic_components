import 'package:flutter/material.dart';

class SyntonicDialogWithTwoButton extends StatelessWidget {
  final String content;
  final String button1Name;
  final String button2Name;

  const SyntonicDialogWithTwoButton(
      {required this.content,
      required this.button1Name,
      required this.button2Name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(button1Name),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(button2Name),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
