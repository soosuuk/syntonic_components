import 'package:syntonic_components/configs/themes/syntonic_dark_theme.dart';
import 'package:syntonic_components/configs/themes/syntonic_light_theme.dart';
import 'package:syntonic_components/gen/l10n/app_localizations.dart';
import 'package:syntonic_components/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../services/rating_service.dart';

/// The widget is an initial widget for the app.
class App extends StatelessWidget {
  App({required this.home, required this.primaryColor});

  /// An initial screen when the app is built.
  final Widget home;

  /// A primary color for the app.
  /// Apply the color as primary color in the app.
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
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
      theme: lightTheme(primaryColor: primaryColor),
      darkTheme: darkTheme(primaryColor: primaryColor),
      home: home,
      debugShowCheckedModeBanner: false,
      // supportedLocales: [
      //   Locale('ja', ''),
      // // Locale('en', '')
      // ],
      // localizationsDelegates: localizationDelegates,
      localizationsDelegates: localizationDelegates,
    );
  }

  /// TODO: このFunctionは、jsonからarbへの移行が終わったら削除します。
  List<LocalizationsDelegate<dynamic>> get localizationDelegates {
    // List<LocalizationsDelegate<dynamic>> localizationDelegateOld = [
    //   TranslatorDelegate(),
    //   GlobalMaterialLocalizations.delegate,
    //   GlobalCupertinoLocalizations.delegate,
    //   GlobalWidgetsLocalizations.delegate,
    // ];
    List<LocalizationsDelegate<dynamic>> localizationDelegateNew =
        AppLocalizations.localizationsDelegates;
    return  localizationDelegateNew;
  }
}
