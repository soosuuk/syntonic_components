import 'package:flutter/material.dart';

class SyntonicDialogWithOneButton extends StatelessWidget {
  final String title;
  final String content;
  final String buttonName;

  const SyntonicDialogWithOneButton(
      {required this.title, required this.content, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    if (title != null) {
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
          TextButton(
            child: Text(buttonName),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
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
            child: Text(buttonName),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}
