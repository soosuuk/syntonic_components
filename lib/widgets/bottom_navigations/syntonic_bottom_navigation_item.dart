import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SyntonicBottomNavigationItem extends StatelessWidget {
  final SyntonicBaseView screen;
  final String label;
  final Icon icon;
  final int index;
  late bool hasBadge;
  final int badgeVal;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  SyntonicBottomNavigationItem({
    required this.screen,
    required this.label,
    required this.icon,
    required this.index,
    this.hasBadge = false,
    this.badgeVal = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return screen;
          },
        );
      },
    );
  }

}