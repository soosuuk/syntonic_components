import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SyntonicAdBanner extends StatefulWidget {
  const SyntonicAdBanner({Key? key}) : super(key: key);

  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<SyntonicAdBanner> {
  BannerAd? _ad;
  AdSize? _adSize;
  bool _isAdLoaded = false;

  Future<AdSize?> _getAdSize(
      BuildContext context, BoxConstraints constraints) async {
    print('こうこく');
    await AdSize.getAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).orientation == Orientation.portrait
          ? Orientation.portrait
          : Orientation.landscape,
      constraints.maxWidth.toInt(),
    ).then((value) {
      print('ADサイズ');
      _adSize = value;
    });
    return _adSize;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          alignment: Alignment.center,
          height: 56,
          child: FutureBuilder<AdSize?>(
            future: _getAdSize(context, constraints),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!_isAdLoaded) {
                  _ad = BannerAd(
                    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                    size: _adSize!,
                    request: const AdRequest(),
                    listener: BannerAdListener(
                      onAdLoaded: (_) {
                        setState(() {
                          _isAdLoaded = true;
                        });
                      },
                      onAdFailedToLoad: (ad, error) {
                        ad.dispose();
                        print(
                            'Ad load failed (code=${error.code} message=${error.message})');
                      },
                    ),
                  );
                  _ad!.load();
                  // return AdWidget(ad: _ad!);
                }
                return AdWidget(ad: _ad!);
              } else {
                return Container();
              }
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }
}
