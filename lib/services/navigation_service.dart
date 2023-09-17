import 'package:syntonic_components/services/localization_service.dart';
import 'package:syntonic_components/widgets/snack_bars/syntonic_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class NavigationService {
  static final _instance = NavigationService._internal();

  NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  /// This key is root key in this application.
  /// Indicate the root screen.
  /// Typically use it like [navigatorKey.currentContext].
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Transition the [screen] to next screen.
  static Future<dynamic> pushScreen(
      {required context, required Widget screen}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  /// Display the [screen] as modal screen over a current screen.
  static Future<dynamic> pushFullscreenDialog({required Widget screen}) {
    return Navigator.push(
      NavigationService().navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => screen,
        fullscreenDialog: true,
      ),
    );
  }

  /// Launch the [url] in application.
  /// Forcibly open a URL, if a platform is web.
  static launchUrlInApp({required String url}) async {
    final Uri _uri = Uri.parse(url);

    if (!await launchUrl(
      _uri,
      mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.inAppWebView,
    )) {
      SyntonicSnackBar().showSnackBar(
          context: NavigationService().navigatorKey.currentContext!,
          message: 'Could not get url.');
    }
  }

  /// Launch the [url] in browser.
  static launchUrlInBrowser({required String url}) async {
    final Uri _uri = Uri.parse(url);

    if (!await launchUrl(
      _uri,
      mode: kIsWeb ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
      // mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
    )) {
      SyntonicSnackBar().showSnackBar(
          context: NavigationService().navigatorKey.currentContext!,
          message: 'Could not get url');
    }
  }
}
