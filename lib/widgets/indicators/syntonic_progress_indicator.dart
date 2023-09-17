import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SyntonicProgressIndicator extends StatelessWidget {

  final bool iShowProgress;

  const SyntonicProgressIndicator({required this.iShowProgress});

  const SyntonicProgressIndicator.show(
    {this.iShowProgress = true});

  const SyntonicProgressIndicator.hide(
    {this.iShowProgress = false,});

  @override
  Widget build(BuildContext context) {
    return Center(widthFactor: 2, heightFactor: 2,
        child: SizedBox(height:24, width: 24, child: iShowProgress ? const CircularProgressIndicator(strokeWidth: 3.0) : const SizedBox())
    );
  }


  void showProgressDialogFullScreen(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }


}