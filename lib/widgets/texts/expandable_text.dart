import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 class ExpandableText extends StatelessWidget {
  const ExpandableText({
      required this.text,
      required this.textStyle,
        this.trimLines = 2,
      });

  final String text;
  final TextStyle textStyle;
  final int trimLines;

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
        create: (context) => BaseText2State(),
    child: Consumer<BaseText2State>(
    builder: (context, model, child) {
      TextSpan link = TextSpan(
          text: model.isOverFlowStateVisible ? " ..." + 'See more' :  " " + 'Close',
          style: textStyle.copyWith(color: SyntonicColor.primary_color),
          recognizer: TapGestureRecognizer()..onTap = () => model.changeExpandCollapseState()
      );

      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          assert(constraints.hasBoundedWidth);
          final double maxWidth = constraints.maxWidth;
          // Create a TextSpan with data
          final text = TextSpan(
            text: this.text,
          );
          // Layout and measure link
          TextPainter textPainter = TextPainter(
            text: link,
            textDirection: TextDirection.rtl,//better to pass this from master widget if ltr and rtl both supported
            maxLines: this.trimLines,
            ellipsis: '...',
          );
          textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
          final linkSize = textPainter.size;
          // Layout and measure text
          textPainter.text = text;
          textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
          final textSize = textPainter.size;
          // Get the endIndex of data
          int? endIndex;
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
          TextSpan textSpan;
          if (textPainter.didExceedMaxLines) {
            textSpan = TextSpan(
              text: model.isOverFlowStateVisible
                  ? this.text.substring(0, endIndex)
                  : this.text,
              style: textStyle,
              children: <TextSpan>[link],
            );
          } else {
            textSpan = TextSpan(
              text: this.text,
              style: textStyle,
            );
          }
          return InkWell(
            onTap: () {
              model.changeExpandCollapseState();
            },
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.clip,
              text: textSpan,
            )
          );
        },
      );
    }));
  }
}

class BaseText2State extends ChangeNotifier {
  bool isOverFlowStateVisible = true;

  changeExpandCollapseState() {
    isOverFlowStateVisible = !isOverFlowStateVisible;
    notifyListeners();
  }
}