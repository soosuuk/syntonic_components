import 'package:flutter/services.dart';

class VibrateService {
  void vibrate()  {
    HapticFeedback.vibrate();
  }

  Future<void> doubleClick() async {
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 180));
    HapticFeedback.mediumImpact();
  }

  void click() {
    HapticFeedback.lightImpact();
  }

  void clickMedium() {
    HapticFeedback.mediumImpact();
  }

  void clickHard() {
    HapticFeedback.heavyImpact();
  }
}
