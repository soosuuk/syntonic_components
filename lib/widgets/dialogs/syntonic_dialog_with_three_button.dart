import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicDialogWithThreeButton extends StatelessWidget {
  final String title;
  final String content;
  final String button1Name;
  final String button2Name;
  final String button3Name;

  SyntonicDialogWithThreeButton({
    required this.title,
    required this.content,
    required this.button1Name,
    required this.button2Name,
    required this.button3Name
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        new Column(
          children: [
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
            TextButton(
              child: Text(button3Name),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
    );
  }
}