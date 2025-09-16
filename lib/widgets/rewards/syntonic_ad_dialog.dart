// NOTE: You must register a NativeAdFactory with the given factoryId ('adFactory') on the platform side.
// For Flutter, see: https://pub.dev/packages/google_mobile_ads#native-ads

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_button.dart';

class SyntonicAdDialog {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  void _loadNativeAd(VoidCallback? onClosed, BuildContext context) {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'adFactory', // Ensure you have registered this factory in your app
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _isAdLoaded = true;
          _showAdDialogInternal(context, onClosed);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _isAdLoaded = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load ad: $error')),
          );
        },
      ),
    );
    _nativeAd!.load();
  }

  void _showAdDialogInternal(BuildContext context, VoidCallback? onClosed) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: _isAdLoaded && _nativeAd != null
                    ? AdWidget(ad: _nativeAd!)
                    : const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(height: 16),
              SyntonicButton.filled(
                text: '閉じる',
                onTap: () {
                  Navigator.of(context).pop();
                  onClosed?.call();
                  _nativeAd?.dispose();
                  _nativeAd = null;
                  _isAdLoaded = false;
                },
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAdDialog(BuildContext context, {VoidCallback? onClosed}) {
    if (_isAdLoaded && _nativeAd != null) {
      _showAdDialogInternal(context, onClosed);
    } else {
      _loadNativeAd(onClosed, context);
    }
  }
}

