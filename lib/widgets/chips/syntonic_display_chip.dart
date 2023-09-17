import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/lists/syntonic_list_item.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicDisplayChip extends StatelessWidget {
  final Widget? icon;
  final String text;
  bool isMini;
  bool isSetColor;
  bool isRectangular;

  SyntonicDisplayChip(
      {required this.text,
      this.icon,
      this.isMini = false,
      this.isRectangular = false,
      this.isSetColor = false});

  SyntonicDisplayChip.mini({required String text, Icon? icon})
      : this(text: text, icon: icon, isMini: true);

  SyntonicDisplayChip.rectangular({required String text, Icon? icon})
      : this(text: text, icon: icon, isRectangular: true);

  @override
  Widget build(BuildContext context) {
    bool _isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (isRectangular) {
      return Chip(
        label: CaptionText(text: text,),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: _isDarkTheme ? Colors.white24 : SyntonicColor.black12)
        ),
        labelPadding: const EdgeInsets.only(left: 0.0),
        avatar: icon,
      );

    } else {
      return RawChip(
        shape: const StadiumBorder(
            side: BorderSide(
              width: 0,
              color: Colors.transparent,
            )),
        backgroundColor: isMini && isSetColor
            ? SyntonicColor.primary_color12
            : isMini
            ? (MediaQuery.of(context).platformBrightness == Brightness.light)
            ? SyntonicColor.black4
            : SyntonicColor.white4
            : null,
        visualDensity:
        isMini ? const VisualDensity(horizontal: 0.0, vertical: -3) : null,
        showCheckmark: false,
        label: CaptionText(
            text: text,
            overflow: TextOverflow.ellipsis,
            textColor:
            isSetColor ? Theme.of(context).colorScheme.primary : null),
        avatar: icon,
      );
    }
  }
}
