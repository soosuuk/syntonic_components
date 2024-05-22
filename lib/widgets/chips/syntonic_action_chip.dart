import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../texts/body_2_text.dart';

class SyntonicActionChip extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Widget? child;

  const SyntonicActionChip(
      {required this.label, this.onPressed,
      this.child,
      this.icon,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool _isDarkTheme = brightness == Brightness.dark;
    return Theme(
      data: ThemeData(canvasColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.21)),
      child: ActionChip(
        pressElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
disabledColor: Colors.transparent,
color: MaterialStateProperty.all<Color>(Colors.transparent),
        onPressed: onPressed,
        // メモ： Expandedをそのまま使うと以下のExceptionがあるためWrapにした
        // Exception：Incorrect use of ParentDataWidget.
        // The offending Expanded is currently placed inside a _ChipRenderWidget widget.
        // （_ChipRenderWidgetというのはActionChipの中の子widget）
        label: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [child != null ? Padding(padding: EdgeInsets.only(right: 8), child: child,) : const SizedBox(), Body2Text(text: label, textColor: Colors.white,), onPressed != null ? Icon(Icons.keyboard_arrow_right, size: 20, color: Colors.white,) : SizedBox(),],
          ),
        ),
        // label: Expanded(child: Row(children: [child ?? const SizedBox(), Subtitle2Text(text: label)],)
        // ),
        padding: EdgeInsets.zero,
        avatar: icon,
        backgroundColor: Colors.transparent,
      ),
    );
    return ActionChip(
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
//       shadowColor: Colors.transparent,
//       surfaceTintColor: Colors.transparent,
// color: MaterialStateProperty.all<Color>(Colors.transparent),
      onPressed: onPressed,
      // メモ： Expandedをそのまま使うと以下のExceptionがあるためWrapにした
      // Exception：Incorrect use of ParentDataWidget.
      // The offending Expanded is currently placed inside a _ChipRenderWidget widget.
      // （_ChipRenderWidgetというのはActionChipの中の子widget）
      label: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: [child ?? const SizedBox(), Body2Text(text: label), Icon(Icons.keyboard_arrow_right, size: 20,),],
        ),
      ),
      // label: Expanded(child: Row(children: [child ?? const SizedBox(), Subtitle2Text(text: label)],)
      // ),
      padding: EdgeInsets.zero,
      avatar: icon,
      backgroundColor: Colors.transparent,
    );
  }
}
