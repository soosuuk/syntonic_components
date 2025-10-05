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

  final Future<bool> Function(BuildContext context)? onCheckSupportedVersion;

  List<LocalizationsDelegate<dynamic>> localizationDelegates;

  @override
  Widget build(BuildContext context) {
    NavigationService();

    return FutureBuilder<bool>(
      future: onCheckSupportedVersion != null
          ? onCheckSupportedVersion!(context)
          : Future.value(true),
      builder: (context, snapshot) {
        RatingService();
        return MaterialApp(
          // scrollBehavior: const _ClampingScrollBehavior(),
          navigatorKey: NavigationService().navigatorKey,
          theme: lightTheme(colorScheme: colorScheme),
          darkTheme: darkTheme(colorScheme: colorScheme),
          navigatorObservers: <NavigatorObserver>[
            NavigationService.routeObserver
          ],
          home: (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == true)
              ? Container(color: Colors.white)
              : home,
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('ja', ''),
            // Locale('en', ''),
          ],
          localizationsDelegates: localizationDelegates,
        );
      },
    );
  }
}

class _ClampingScrollBehavior extends ScrollBehavior {
  const _ClampingScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // 常に ClampingScrollPhysics（= Android 標準のバウンドなし）を使う
    return const BouncingScrollPhysics();
  }
}
