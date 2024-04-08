import 'package:syntonic_components/configs/themes/syntonic_dark_theme.dart';
import 'package:syntonic_components/configs/themes/syntonic_light_theme.dart';
import 'package:syntonic_components/services/navigation_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/rating_service.dart';

/// The widget is an initial widget for the app.
class App extends StatelessWidget {
  App(
      {required this.home,
      required this.colorScheme,
      required this.localizationDelegates,
      this.onCheckSupportedVersion});

  /// An initial screen when the app is built.
  final Widget home;

  /// A primary color for the app.
  /// Apply the color as primary color in the app.
  final ColorScheme colorScheme;

  final Function(BuildContext context)? onCheckSupportedVersion;

  List<LocalizationsDelegate<dynamic>> localizationDelegates;

  @override
  Widget build(BuildContext context) {
    NavigationService();

    if (onCheckSupportedVersion != null) {
      print('チェックバージョン');
      onCheckSupportedVersion!(context);
    }

    RatingService();
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      navigatorKey: NavigationService().navigatorKey,
      theme: lightTheme(colorScheme: colorScheme),
      darkTheme: darkTheme(colorScheme: colorScheme),
      home: home,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('ja', ''),
        Locale('en', '')
      ],
      localizationsDelegates: localizationDelegates,
    );
  }
}
