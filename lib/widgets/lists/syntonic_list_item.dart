import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/configs/constants/syntonic_constraint.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_button.dart';
import 'package:syntonic_components/widgets/chips/syntonic_display_chip.dart';
import 'package:syntonic_components/widgets/selectors/syntonic_checkbox.dart';
import 'package:syntonic_components/widgets/selectors/syntonic_radio_button.dart';
import 'package:syntonic_components/widgets/selectors/syntonic_switch.dart';
import 'package:syntonic_components/widgets/texts/body_1_text.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/caption_text.dart';
import 'package:syntonic_components/widgets/texts/headline_4_text.dart';
import 'package:syntonic_components/widgets/texts/headline_5_text.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';
import 'package:syntonic_components/widgets/texts/overline_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_1_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../dividers/syntonic_divider.dart';
import '../buttons/syntonic_pop_up_menu_button.dart';
import 'list_item.dart';

enum ActionWidgetPosition { Leading, Trailing }

enum TitleTextStyle {
  Headline4,
  Headline5,
  Headline6,
  Subtitle1,
  Subtitle2,
  Body1,
  Body2,
  Caption,
  Overline
}

// ignore: must_be_immutable
class SyntonicListItem extends ListItem {
  /// A text that first line of this list.
  @required
  late String title;

  /// Enabled?
  ///
  /// Apply [Opacity] If set "false".
  final bool isEnabled;

  /// A widget to display bottom of this list.
  ///
  /// Typically a [Chip] widget.
  final Widget? bottomWidget;

  /// Cross axis alignment.
  ///
  /// Default value is "center".
  final CrossAxisAlignment textCrossAxisAlignment;

  /// Cross axis alignment.
  ///
  /// Default value is "start".
  final CrossAxisAlignment crossAxisAlignment;

  /// Text align for [Text] widget.
  ///
  /// Typically [TextAlign.left].
  final TextAlign textAlign;

  /// Whether set a padding that left, top, right, bottom of this list.
  ///
  /// Default padding is 16.
  ///
  /// Default value is true.
  final bool hasPadding;

  final bool isReorderMode;

  /// A widget is a [Text] for [title].
  ///
  /// [Text] depends on [TitleTextStyle].
  ///
  /// This widget is set in a named constructor.
  late Widget titleWidget;

  /// Main axis alignment.
  /// Apply to all [Row] widget.
  late MainAxisAlignment mainAxisAlignment;

  /// Main axis alignment for subtitle.
  /// Apply it to between [subtitle] and [optionalWidgetSubtitle].
  /// Default [MainAxisAlignment] is [mainAxisAlignment].
  ///
  /// Typically set [MainAxisAlignment.spaceBetween]
  /// if you have space between [subtitle] and [optionalWidgetSubtitle].
  final MainAxisAlignment? mainAxisAlignmentSubtitle;

  /// Main axis alignment for title.
  /// Apply it to between [title] and [optionalWidgetTitle].
  /// Default [MainAxisAlignment] is [mainAxisAlignment].
  ///
  /// Typically set [MainAxisAlignment.spaceBetween]
  /// if you have space between [title] and [optionalWidgetTitle].
  final MainAxisAlignment? mainAxisAlignmentTitle;

  /// Minimum height of this list item.
  ///
  /// Default minimum height is 56.
  ///
  /// Typically use to sub header of front layer in backdrop.
  late double? minHeight;

  /// Whether needs divider of this list bottom.
  ///
  /// whether needs divider depends on [TitleTextStyle].
  ///
  /// If [leadingWidget] and [trailingWidget] are null, automatically set true.
  late bool hasDivider = false;

  /// Whether needs to "See more".
  final bool needsSeeMore;

  /// If want to display all characters to [subtitleWidget], Set true.
  /// State is set depends on [TitleTextStyle] automatically.
  late bool? needsSubtitleOverFlowStateVisible = false;

  /// If want to display all characters to [titleWidget], Set true.
  late bool needsTitleOverFlowStateVisible = false;

  /// Text style of [titleWidget].
  ///
  /// Automatically apply a text style of [subtitleWidget] depends on value of this variable.
  late TitleTextStyle titleTextStyle;

  /// A widget to display before this list.
  ///
  /// Typically an [Icon] widget.
  Widget? leadingWidget;

  /// Called when the user long-presses on this list.
  GestureLongPressCallback? onLongPress;

  /// Called when the user tap on this list.
  VoidCallback? onTap;

  /// A widget to display after [titleWidget].
  ///
  /// If needs some widget that support [titleWidget], set some widget.
  Widget? optionalWidgetTitle;

  /// A widget to display top of this list.
  ///
  /// Typically a [OverlineText] widget.
  Widget? topWidget;

  /// A widget to display after [subtitleWidget].
  ///
  /// If needs some widget that support [subtitleWidget], set some widget.
  Widget? optionalWidgetSubtitle;

  /// A widget is a [Text] for [subtitle].
  ///
  /// [Text] depends on [TitleTextStyle].
  ///
  /// This widget is set in a named constructor.
  Widget? subtitleWidget;

  /// A text that second line of this list.
  String? subtitle;

  /// If need to set subtitle color, set some color.
  Color? subTitleColor;

  /// If need to set title color, set some color.
  Color? titleColor;

  /// If need to set background color.
  Color? backgroundColor;

  /// Max line for title.
  int? titleMaxLines;

  /// A widget to display after this list.
  ///
  /// Typically an [Icon] or a [TextButton] or a [Text] or a [Checkbox] or a [Radio] or a [Switch] widget.
  Widget? trailingWidget;

  SyntonicListItem(
      {Key? key,
      required this.title,
      this.isEnabled = true,
      this.bottomWidget,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.textCrossAxisAlignment = CrossAxisAlignment.center,
      this.needsSeeMore = false,
      this.hasPadding = true,
      this.isReorderMode = false,
      this.titleMaxLines,
      this.subtitle,
      this.subTitleColor,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisAlignmentSubtitle,
      this.mainAxisAlignmentTitle,
      this.minHeight,
      this.hasDivider = true,
      this.needsSubtitleOverFlowStateVisible,
      this.needsTitleOverFlowStateVisible = false,
      this.leadingWidget,
      this.titleColor,
      this.backgroundColor,
      this.trailingWidget,
      this.textAlign = TextAlign.left,
      this.onLongPress,
      this.onTap,
      this.optionalWidgetSubtitle,
      this.optionalWidgetTitle,
      this.topWidget,
      TitleTextStyle? titleTextStyle})
      : super(key: key) {
    this.titleTextStyle =
        titleTextStyle != null ? titleTextStyle : TitleTextStyle.Subtitle2;
    this.hasDivider = !hasDivider ||
            titleTextStyle == TitleTextStyle.Headline4 ||
            titleTextStyle == TitleTextStyle.Headline5 ||
            titleTextStyle == TitleTextStyle.Headline6 ||
            titleTextStyle == TitleTextStyle.Overline ||
            leadingWidget != null ||
            trailingWidget != null
        ? false
        : true;

    needsSubtitleOverFlowStateVisible = needsSubtitleOverFlowStateVisible ??
        titleTextStyle == TitleTextStyle.Headline4 ||
                titleTextStyle == TitleTextStyle.Headline5 ||
                titleTextStyle == TitleTextStyle.Headline6 ||
                titleTextStyle == TitleTextStyle.Overline
            ? true
            : false;

    switch (this.titleTextStyle) {
      case TitleTextStyle.Headline4:
        titleWidget = Headline4Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Subtitle2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Headline5:
        titleWidget = Headline5Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Body2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Headline6:
        titleWidget = Headline6Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Body2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Subtitle1:
        titleWidget = Subtitle1Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Body2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Subtitle2:
        titleWidget = Subtitle2Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Body2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Body1:
        titleWidget = Body1Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = CaptionText(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Body2:
        titleWidget = Body2Text(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Subtitle2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: this.needsSubtitleOverFlowStateVisible!
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Caption:
        titleWidget = CaptionText(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Subtitle2Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: TextOverflow.visible,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
      case TitleTextStyle.Overline:
        titleWidget = OverlineText(
            text: this.title,
            textColor: this.titleColor,
            overflow: this.needsTitleOverFlowStateVisible
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            textAlign: textAlign,
            maxLines: titleMaxLines);
        if (this.subtitle != null) {
          subtitleWidget = Headline5Text(
              text: this.subtitle!,
              textColor: this.subTitleColor,
              overflow: TextOverflow.visible,
              textAlign: textAlign,
              maxLines: titleMaxLines,
              needsSeeMore: needsSeeMore);
        }
        break;
    }
  }

  /// Text button.
  SyntonicListItem.textButton({
    required onTextButtonTap,
    required String textButtonText,
    required String title,
    leadingWidget,
    needsOverFlowStateVisible = false,
    Widget? optionalWidgetSubtitle,
    Widget? optionalWidgetTitle,
    String? subtitle,
    trailingText,
    TitleTextStyle? titleTextStyle,
  }) : this(
            title: title,
            leadingWidget: leadingWidget,
            optionalWidgetSubtitle: optionalWidgetSubtitle,
            optionalWidgetTitle: optionalWidgetTitle,
            subtitle: subtitle,
            trailingWidget: Container(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: SyntonicButton.transparent(
                    onTap: onTextButtonTap, text: textButtonText)),
            titleTextStyle: titleTextStyle ?? TitleTextStyle.Headline6);

  /// Text.
  SyntonicListItem.text(
      {required String title,
      needsTitleOverFlowStateVisible = false,
      trailingText})
      : this(
            title: title,
            needsTitleOverFlowStateVisible: needsTitleOverFlowStateVisible,
            trailingWidget: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Subtitle2Text(text: trailingText)),
            titleTextStyle: TitleTextStyle.Body2);

  /// Radio Button.
  SyntonicListItem.radioButton(
      {Key? key,
      required BuildContext context,
      required int groupValue,
      required Function(int) onRadioStateChanged,
      String? subtitle,
      required String title,
      required int index,
      bool isReorderMode = false,
      Widget? bottomWidget,
      CrossAxisAlignment textCrossAxisAlignment = CrossAxisAlignment.center,
      ActionWidgetPosition radioButtonPosition = ActionWidgetPosition.Trailing,
      Widget? widget,
      needsOverFlowStateVisible = false,
      needsSubtitleOverFlowStateVisible = true,
      Widget? popUpMenuWidget,
      bool? hasDivider = false,
      bool needsSeeMore = false,
      GestureLongPressCallback? onLongPress,
      TitleTextStyle? titleTextStyle,
      int? titleMaxLines})
      : this(
            key: key,
            onTap: () => onRadioStateChanged(index),
            title: title,
            subtitle: subtitle,
            isReorderMode: isReorderMode,
            needsSeeMore: needsSeeMore,
            hasDivider: hasDivider!,
            onLongPress: onLongPress,
            bottomWidget: bottomWidget,
            textCrossAxisAlignment: textCrossAxisAlignment,
            needsSubtitleOverFlowStateVisible:
                needsSubtitleOverFlowStateVisible,
            leadingWidget: radioButtonPosition == ActionWidgetPosition.Leading
                ? SyntonicRadioButton(
                    context: context,
                    value: index,
                    groupValue: groupValue,
                    onChanged: onRadioStateChanged)
                : widget != null
                    ? (isReorderMode)
                        ? null
                        : widget
                    : null,
            trailingWidget: radioButtonPosition == ActionWidgetPosition.Trailing
                ? SyntonicRadioButton(
                    context: context,
                    value: index,
                    groupValue: groupValue,
                    onChanged: onRadioStateChanged)
                : widget != null
                    ? (isReorderMode)
                        ? null
                        : widget
                    : null,
            titleTextStyle: titleTextStyle,
            titleMaxLines: titleMaxLines);

  /// Checkbox.
  SyntonicListItem.checkbox(
      {Key? key,
      GestureLongPressCallback? onLongPress,
      required Function(bool?) onCheckStateChanged,
      String? subtitle,
      required String title,
      required bool isChecked,
      Widget? bottomWidget,
      Widget? optionalWidgetTitle,
      Widget? optionalWidgetSubtitle,
      Widget? topWidget,
      CrossAxisAlignment textCrossAxisAlignment = CrossAxisAlignment.center,
      ActionWidgetPosition checkboxPosition = ActionWidgetPosition.Trailing,
      Widget? widget,
      MainAxisAlignment? mainAxisAlignmentTitle,
      needsTitleOverFlowStateVisible = false,
      TitleTextStyle? titleTextStyle,
      int? titleMaxLines})
      : this(
            key: key,
            onLongPress: onLongPress,
            onTap: () => onCheckStateChanged(!isChecked),
            title: title,
            bottomWidget: bottomWidget,
            topWidget: topWidget,
            textCrossAxisAlignment: textCrossAxisAlignment,
            subtitle: subtitle,
            leadingWidget: checkboxPosition == ActionWidgetPosition.Leading
                ? SyntonicCheckbox(
                    isChecked: isChecked,
                    onCheckStateChanged: onCheckStateChanged)
                : widget,
            mainAxisAlignmentTitle: mainAxisAlignmentTitle,
            needsTitleOverFlowStateVisible: needsTitleOverFlowStateVisible,
            optionalWidgetTitle: optionalWidgetTitle,
            optionalWidgetSubtitle: optionalWidgetSubtitle,
            trailingWidget: checkboxPosition == ActionWidgetPosition.Trailing
                ? SyntonicCheckbox(
                    isChecked: isChecked,
                    onCheckStateChanged: onCheckStateChanged)
                : widget,
            titleTextStyle: titleTextStyle ??
                (subtitle != null
                    ? TitleTextStyle.Caption
                    : TitleTextStyle.Subtitle2),
            titleMaxLines: titleMaxLines);

  /// Switch.
  SyntonicListItem.switches(
      {required Function(bool?) onSwitchStateChanged,
      String? subtitle,
      required String title,
      required bool isSwitchedOn,
      Widget? widget,
      needsSubtitleOverFlowStateVisible = true,
      needsTitleOverFlowStateVisible = true,
      TitleTextStyle? titleTextStyle,
      TextAlign textAlign = TextAlign.left})
      : this(
            onTap: () => onSwitchStateChanged(!isSwitchedOn),
            title: title,
            subtitle: subtitle,
            leadingWidget: widget,
            needsSubtitleOverFlowStateVisible:
                needsSubtitleOverFlowStateVisible,
            needsTitleOverFlowStateVisible: needsTitleOverFlowStateVisible,
            textAlign: textAlign,
            trailingWidget: SyntonicSwitch(
                isSwitchedOn: isSwitchedOn,
                onSwitchStateChanged: (value) =>
                    onSwitchStateChanged(!isSwitchedOn)),
            titleTextStyle: titleTextStyle ?? TitleTextStyle.Subtitle2);

  /// Pop up menu button.
  SyntonicListItem.popUpMenuButton(
      {required Key key,
      String? overLine,
      required String title,
      required bool isReorderMode,
      @Deprecated('Should use [SyntonicPopupMenuButton]instead of this')
          List<PopUpMenuItem>? popupMenuItems,
      SyntonicPopupMenuButton? popupMenuButton,
      VoidCallback? onTap,
      GestureLongPressCallback? onLongPress,
      Widget? topWidget,
      Widget? bottomWidget,
      Widget? widget,
      needsOverFlowStateVisible = false})
      : this(
            key: key,
            onTap: !isReorderMode ? onTap : null,
            title: title,
            subtitle: overLine,
            leadingWidget: widget,
            topWidget: topWidget,
            bottomWidget: bottomWidget,
            trailingWidget: (isReorderMode)
                ? const Icon(Icons.drag_handle)
                : (popupMenuButton != null)
                    ? popupMenuButton
                    : SyntonicPopupMenuButton(
                        icon: Icons.more_vert, popUpMenuItem: popupMenuItems),
            onLongPress: !isReorderMode ? onLongPress : null,
            titleTextStyle: TitleTextStyle.Subtitle2);

  @override
  Widget build(BuildContext context) {
    Color? inkColor = onTap != null ? null : Colors.transparent;

    return Opacity(
      opacity: isEnabled ? 1 : 0.38,
      child: InkWell(
          splashColor: inkColor,
          highlightColor: inkColor,
          hoverColor: inkColor,
          onLongPress: isReorderMode ? null : onLongPress,
          onTap: isReorderMode ? null : onTap,
          child: Column(children: [
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: hasPadding ? _verticalPadding : 0),
                color: backgroundColor,
                child: Row(
                  crossAxisAlignment: textCrossAxisAlignment,
                  children: [
                    leadingWidget != null
                        ? ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: 48, minHeight: 32
                          // minHeight: 48
                        ),
                        child: Padding(padding: SyntonicConstraint.horizontal16, child: Center(child: leadingWidget),)
                      // Positioned(
                      // top: -10,
                      // child: this.leadingWidget!)
                    )
                        : SizedBox(width: hasPadding ? 16 : 0),
                    Expanded(
                      child: Column(
                          crossAxisAlignment:
                          crossAxisAlignment,
                          children: [
                            if (bottomWidget != null)
                              const SizedBox(height: 6),
                            topWidget != null
                                ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4),
                                child: topWidget)
                                : const SizedBox(),
                            _texts,
                            bottomWidget ?? const SizedBox()
                          ]),
                    ),
                    trailingWidget != null
                        ? ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: 48, minHeight: 48),
                        child: Padding(padding: SyntonicConstraint.horizontal16, child: Center(
                            child: isReorderMode
                                ? const Icon(Icons.drag_handle)
                                : trailingWidget),))
                        : SizedBox(width: hasPadding ? 16 : 0),
                  ],
                )),
            if (hasDivider) SyntonicDivider()
          ])),
    );
  }

  /// Set up [titleWidget] and [subtitleWidget] texts.
  ///
  /// If needs [optionalWidgetTitle] or[optionalWidgetSubtitle], Set after
  /// [titleWidget] or [subtitleWidget].
  Widget get _texts {
    if (subtitle != null) {
      return Column(
        children: <Widget>[
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: mainAxisAlignmentTitle ?? mainAxisAlignment,
              children: [
                Flexible(child: titleWidget),
                optionalWidgetTitle != null
                    ? Row(children: [
                        const SizedBox(width: 4),
                        optionalWidgetTitle!
                      ])
                    : const SizedBox(width: 0)
              ]),
          const SizedBox(height: 4),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: mainAxisAlignmentSubtitle ?? mainAxisAlignment,
              children: [
                Flexible(child: subtitleWidget!),
                optionalWidgetSubtitle != null
                    ? Row(children: [
                        const SizedBox(width: 4),
                        optionalWidgetSubtitle!
                      ])
                    : const SizedBox(width: 0)
              ]),
        ],
      );
    } else {
      return Row(
          mainAxisAlignment: mainAxisAlignmentTitle ?? mainAxisAlignment,
          children: [
            Flexible(child: titleWidget),
            this.optionalWidgetTitle != null
                ? Row(children: [const SizedBox(width: 4), optionalWidgetTitle!])
                : const SizedBox(width: 0)
          ]);
    }
  }

  /// Get vertical padding depends on [titleTextStyle].
  double get _verticalPadding {
    switch (titleTextStyle) {
      case TitleTextStyle.Headline4:
      case TitleTextStyle.Headline5:
      case TitleTextStyle.Headline6:
      case TitleTextStyle.Subtitle1:
        return 16;
      case TitleTextStyle.Subtitle2:
      case TitleTextStyle.Body1:
      case TitleTextStyle.Body2:
      case TitleTextStyle.Caption:
      case TitleTextStyle.Overline:
        return 12;
    }
  }
}
