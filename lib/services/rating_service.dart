import 'package:rate_my_app/rate_my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingService {
  static final _instance = RatingService._internal();

  RatingService._internal();

  factory RatingService() {
    return _instance;
  }

  static final RateMyApp _rating = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 1,
    minLaunches: 1,
    remindDays: 1,
    remindLaunches: 1,
  );

  static void init({required BuildContext context}) {
    _rating.init().then((_) {
      if (_rating.shouldOpenDialog) {
        _rating.showRateDialog(
          context,
        );
      }
    });
  }
}
