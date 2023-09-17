import 'package:flutter/material.dart';

class SyntonicSnackBar {
  DateTime initialDate = DateTime.now();

  ///To get picked date[context, selectedDate].
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({required BuildContext context, required String message, SnackBarAction? snackBarAction}) {
    return  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Text(message),
        action: snackBarAction,
      ),
    );
  }

}