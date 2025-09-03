import 'package:flutter/services.dart';

class VibrateService {
  void vibrate()  {
    HapticFeedback.vibrate();
  }

  Future<void> doubleVibrate() async {
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 180));
    HapticFeedback.mediumImpact();
  }
}
