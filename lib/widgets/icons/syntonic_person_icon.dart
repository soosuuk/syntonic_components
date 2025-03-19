import 'package:syntonic_components/models/person_model.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:syntonic_components/widgets/texts/headline_4_text.dart';
import 'package:syntonic_components/widgets/texts/headline_5_text.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/material.dart';

enum IconSize { normal, large, extraLarge, medium, semiSmall, small, mini }

/// A state of [iconShape].
enum IconShape {
  circle,
  rectangle,
}

extension IconSizeExtension on IconSize {
  static final _values = {
    IconSize.normal: 40.0,
    IconSize.large: 88.0,
    IconSize.extraLarge: 112.0,
    IconSize.medium: 56.0,
    IconSize.semiSmall: 32.0,
    IconSize.small: 24.0,
    IconSize.mini: 16.0,
  };

  double? get size => _values[this];
}

class SyntonicPersonIcon extends StatelessWidget {
  @required
  final PersonModel person;
  final IconSize type;
  final bool hasPadding;
  final bool needsBorder;
  final bool needsMainStaffBorder;
  final IconShape shape;

  /// FIXME: You should use this instead of [needsMainStaffBorder].
  // final double borderRadius;

  const SyntonicPersonIcon(
      {Key? key,
      required this.person,
      required this.type,
      this.shape = IconShape.circle,
      this.hasPadding = true,
      this.needsBorder = false,
      this.needsMainStaffBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget _initialText;
    switch (type) {
      case IconSize.normal:
        // print(person.name);
        _initialText = Headline6Text(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
      case IconSize.large:
        _initialText = Headline4Text(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
      case IconSize.extraLarge:
        _initialText = Headline4Text(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
      case IconSize.medium:
        _initialText = Headline5Text(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
      case IconSize.semiSmall:
        _initialText = Subtitle2Text(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
      case IconSize.small:
        _initialText = Subtitle2Text(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
      case IconSize.mini:
        _initialText = CaptionText(
          text: person.name != null && person.name != ''
              ? person.name!.getInitial().toUpperCase()
              : '',
          textColor: Colors.white,
          needsLinkify: false,
        );
        break;
    }

    return Padding(
      padding: EdgeInsets.all(hasPadding ? 16 : 0),
      child: Stack(alignment: Alignment.bottomRight, children: <Widget>[
        person.photoUrl != null
            ? _iconShape(context: context)
            : _getImagePlaceholder(context: context, initialText: _initialText),
        ...?additionalWidget(context: context)
      ]),
    );
  }

  Widget _iconShape({required BuildContext context}) {
    switch (shape) {
      case IconShape.circle:
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  (needsMainStaffBorder) ? type.size! - 3 : type.size!),
              border: Border.all(
                  width: (needsMainStaffBorder)
                      ? 2
                      : (needsBorder)
                          ? 1
                          : 0,
                  color: (needsMainStaffBorder)
                      ? Theme.of(context).colorScheme.surface
                      : Colors.black12)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(type.size!),
            child: Image.network(
              person.photoUrl!,
              width: type.size!,
              height: type.size!,
              fit: BoxFit.cover,
            ),
          ),
        );
      case IconShape.rectangle:
        return ClipRRect(
          // borderRadius: BorderRadius.circular(type.size!),
          child: Image.network(
            person.photoUrl!,
            width: type.size!,
            height: type.size!,
            fit: BoxFit.fill,
          ),
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
        );
    }
  }

  /// Get the placeholder.
  Widget _getImagePlaceholder(
      {required BuildContext context, required Widget initialText}) {
    ///Fixme: この値によって、アイコンを切り替えられる。
    bool _needsInitial = true;
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return !_needsInitial || person.id == null
        ? Stack(
            children: [
              Icon(
                Icons.account_circle,
                size: type.size,
              ),
              Container(
                width: type.size! + 4,
                height: type.size! + 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(type.size! + 2),
                    border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.surface)),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(type.size!),
                //   child: Image.network(
                //     person.photoUrl!,
                //     width: (needsMainStaffBorder) ? type.size! - 6 : type.size!,
                //     height: (needsMainStaffBorder) ? type.size! - 6 : type.size!,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              )
              // SvgPicture.asset(
              //   "assets/images/account_circle.svg",
              //   color: isDarkTheme ? Colors.white54 : SyntonicColor.black56,
              //   width: type.size,
              //   height: type.size,
              //   package: 'syntonic_components',
              // ),
            ],
          )
        : Container(
            width: type.size,
            height: type.size,
            decoration: BoxDecoration(
              color: person.getCustomerColor(
                  id: 1,
                  // id: person.id != null
                  //     ? int.parse(person.id!.toString().getFinal())
                  //     : 1
              ),
              shape: shape == IconShape.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              borderRadius:
                  shape == IconShape.circle ? null : BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: FittedBox(child: this.initialText ?? initialText),
              ),
            ));
  }

  /// Display any additional widgets in over the icon.
  /// Typically use fto icon badge.
  List<Widget>? additionalWidget({required BuildContext context}) => null;

  /// Initial text of [PersonIcon].
  Widget? get initialText => null;
}
