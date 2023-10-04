import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SyntonicActionChip extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final Widget? child;

  const SyntonicActionChip(
      {required this.label,
        required this.onPressed,
        this.child,
        this.icon,
        this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool _isDarkTheme = brightness == Brightness.dark;
    return ActionChip(
        // shape: StadiumBorder(
        //     side: BorderSide(
        //       width: 0.5,
        //       color: _isDarkTheme ? Colors.white12 : Colors.black12,
        //     )
        // ),
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
            children: [
              child ?? const SizedBox(),
              Subtitle2Text(text: label)
            ],
          ),
        ),
        // label: Expanded(child: Row(children: [child ?? const SizedBox(), Subtitle2Text(text: label)],)
        // ),
        avatar: icon,
        backgroundColor: (backgroundColor == null) ?  Colors.transparent : backgroundColor,
    );
  }
}
