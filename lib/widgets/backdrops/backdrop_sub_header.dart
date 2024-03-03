import 'package:flutter/material.dart';

class SyntonicBackdropSubHeader extends StatelessWidget {
  String title;
  final EdgeInsets padding;
  final bool automaticallyImplyLeading;
  final bool automaticallyImplyTrailing;
  final Widget? leading;
  final Widget? trailing;
  late AnimationController controller;
  final Widget? divider;
  final bool isPanelVisible;
  final VoidCallback onBackdropStateChanged;
  final Widget widget;

  SyntonicBackdropSubHeader({
    Key? key,
    required this.title,
    required this.controller,
    required this.isPanelVisible,
    required this.widget,
    required this.onBackdropStateChanged,
    this.padding = const EdgeInsets.all(0),
    this.automaticallyImplyLeading = false,
    this.automaticallyImplyTrailing = true,
    this.leading,
    this.trailing,
    this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildAutomaticLeadingOrTrailing(BuildContext context) =>
        FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(controller),
          child: const Icon(Icons.keyboard_arrow_up),
        );

    return InkWell(
        onTap: onBackdropStateChanged,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: padding,
              child: Row(
                children: <Widget>[
                  // leading ??
                  //     (automaticallyImplyLeading
                  //         ? _buildAutomaticLeadingOrTrailing(context)
                  //         : Container()),
                  Expanded(
                    child: widget,
                  ),
                  // trailing ??
                  //     (automaticallyImplyTrailing
                  //         ? _buildAutomaticLeadingOrTrailing(context)
                  //         : Container()),
                ],
              ),
            ),
            divider ??
                const Divider(height: 4.0, indent: 16.0, endIndent: 16.0),
          ],
        ));
  }
}
