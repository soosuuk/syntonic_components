import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_button.dart';
import 'package:syntonic_components/widgets/texts/body_1_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';

class SyntonicNewDialog extends StatelessWidget {
  final String title;
  final String? body;
  final String? negativeButtonText;
  final String positiveButtonText;
  final VoidCallback? onNegativeButtonTapped;
  final VoidCallback onPositiveButtonTapped;
  final bool isPositiveButtonEnabled;

  const SyntonicNewDialog({
    super.key,
    required this.title,
    this.body,
    this.negativeButtonText,
    required this.positiveButtonText,
    this.onNegativeButtonTapped,
    required this.onPositiveButtonTapped,
    this.isPositiveButtonEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Subtitle2Text(text: title),
      content: body != null ? Body1Text(text: body!) : null,
      actions: [
        if (negativeButtonText != null)
          SyntonicButton.outlined(
            padding: EdgeInsets.zero,
            text: negativeButtonText!,
            onTap: () {
              Navigator.pop(context, null);
              onNegativeButtonTapped?.call();
            },
          ),
        SyntonicButton.filled(
          padding: EdgeInsets.zero,
          onTap: () {
            Navigator.pop(context, null);
            onPositiveButtonTapped.call();
          },
          text: positiveButtonText,
          isEnabled: isPositiveButtonEnabled,
        ),
      ],
    );
  }
}

class SyntonicAdReward {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  bool _earnedReward = false;

  String get _unitId {
    const _env = String.fromEnvironment('ENV', defaultValue: 'prod');
    if (_env == 'prod') {
      if (Platform.isIOS) {
        return 'ca-app-pub-4288011253421893/3528248981'; // 本番 iOS
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-4288011253421893/1083378036'; // 本番 Android
      }
    } else {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/5224354917'; // ステージング iOS
      } else if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/5224354917'; // ステージング Android
      }
    }
    return ''; // fallback
  }

  void _loadRewardedAd({
    VoidCallback? onRewarded,
    required BuildContext context,
    required String title,
    required String body,
    void Function()? onLoaded,
    void Function()? onLoadFailed, // added callback
  }) {
    RewardedAd.load(
      adUnitId: _unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (_earnedReward) {
                onRewarded?.call();
              }
              ad.dispose();
              _rewardedAd = null;
              _isAdLoaded = false;
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              _isAdLoaded = false;
            },
          );

          if (onLoaded != null) {
            onLoaded();
          }
        },
        onAdFailedToLoad: (error) {
          _isAdLoaded = false;
          // if (onLoaded != null) {
          //   onLoaded();
          // }
          // notify caller about load failure so it can close UI if needed
          if (onLoadFailed != null) {
            onLoadFailed();
          }
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _earnedReward = false;
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          _earnedReward = true;
        },
      );
    }
  }

  void _showRewardDialogInternal({
    required BuildContext context,
    required String title,
    required String body,
    VoidCallback? onRewarded,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // 初回ロード
            if (!_isAdLoaded && _rewardedAd == null) {
              _loadRewardedAd(
                onRewarded: onRewarded,
                context: context,
                title: title,
                body: body,
                onLoaded: () {
                  setState(() {});
                },
                onLoadFailed: () {
                  // close the dialog when load fails
                  Navigator.of(context).pop();
                  onRewarded?.call();
                },
              );
            }
            return SyntonicNewDialog(
              title: title,
              body: body,
              negativeButtonText: 'キャンセル',
              positiveButtonText: _isAdLoaded ? '広告を視聴' : '広告をダウンロードしています',
              isPositiveButtonEnabled: _isAdLoaded,
              onNegativeButtonTapped: () => null,
              onPositiveButtonTapped: _isAdLoaded
                  ? () {
                      // Navigator.of(context).pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showRewardedAd();
                      });
                    }
                  : () => null,
            );
          },
        );
      },
    );
  }

  void showRewardDialog({
    required BuildContext context,
    required String title,
    required String body,
    VoidCallback? onRewarded,
  }) {
    _isAdLoaded = false;
    _rewardedAd = null;
    _showRewardDialogInternal(
      context: context,
      title: title,
      body: body,
      onRewarded: onRewarded,
    );
  }
}
