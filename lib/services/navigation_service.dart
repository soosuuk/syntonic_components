import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syntonic_components/widgets/snack_bars/syntonic_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

import '../widgets/syntonic_base_view.dart';

class NavigationService {
  static final _instance = NavigationService._internal();

  NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  static final RouteObserver<PageRoute> routeObserver =
  RouteObserver<PageRoute>();

  /// This key is root key in this application.
  /// Indicate the root screen.
  /// Typically use it like [navigatorKey.currentContext].
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Transition the [screen] to next screen.
  static Future<dynamic> pushScreen(
      {required context, required SyntonicBaseView screen}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  /// Display the [screen] as modal screen over a current screen.
  static Future<dynamic> pushFullscreenDialog(
      {required SyntonicBaseView screen, BuildContext? context}) {
    return Navigator.push(
      context ?? NavigationService().navigatorKey.currentContext!,
      // MaterialPageRoute(
      //   builder: (context) => screen,
      //   fullscreenDialog: true,
      // ),
      PageRouteBuilder(
        fullscreenDialog: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          // ProviderContainer container = ProviderContainer(
          //   overrides: [
          //     isInitializedProvider.(StateProvider<bool>((ref) => false)),
          //   ],
          // );
          return ProviderScope(
            child: screen,
          );
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 500),
        // transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //   const curve = Curves.easeInOutCubicEmphasized; // ここでカスタムのCurveを指定
        //   var curvedAnimation =
        //       CurvedAnimation(parent: animation, curve: curve);
        //   return FadeTransition(opacity: curvedAnimation, child: child);
        // },
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

  static Future<dynamic> replaceScreen(
      {required context, required Widget screen}) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ProviderScope(child: screen)),
            (route) => false);
  }

  /// サインアウト処理を実行
  /// [onSignOut] はサインアウト前の処理（ローカルストレージの削除、Firebase Authのサインアウトなど）を実行するコールバック
  /// [loginScreen] はログイン画面のWidget
  /// [message] はサインアウト後に表示するメッセージ（オプション）
  static Future<void> signOut({
    required Future<void> Function() onSignOut,
    required Widget loginScreen,
    String? message,
  }) async {
    try {
      // サインアウト前の処理を実行
      await onSignOut();
      
      // ログイン画面に遷移
      final context = NavigationService().navigatorKey.currentState?.context;
      if (context != null) {
        NavigationService.replaceScreen(
          context: context,
          screen: loginScreen,
        );
        
        // メッセージが指定されている場合は表示
        if (message != null) {
          SyntonicSnackBar().showSnackBar(
            context: context,
            message: message,
          );
        }
      }
    } catch (e) {
      print('Error during signOut: $e');
    }
  }
}
