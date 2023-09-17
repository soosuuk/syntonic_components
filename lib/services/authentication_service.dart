import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// [AuthenticationService] is a class for authenticate user credentials another
/// service.
class AuthenticationService {
  /// Login with apple.
  static Future<User?> loginWithApple() async {
    final appleProvider = AppleAuthProvider();
    final UserCredential? _user;
    if (kIsWeb) {
      _user = await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      _user = await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }

    return _user.user;
  }

  /// Login with Facebook.
  static Future<Map<String, dynamic>?> loginWithFacebook() async {
    final result = await FacebookAuth.instance.login();

    switch (result.status) {
      case LoginStatus.success:
        try {
          return await FacebookAuth.instance.getUserData();
        } catch (e) {}
        break;
      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        break;
    }
  }
}