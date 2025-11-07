import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../domain/repositories/ad_repository.dart';
import '../services/admob_service.dart';

class AdRepositoryImpl implements AdRepository {
  @override
  Future<void> initialize() async {
    await AdMobService.initialize();
  }

  @override
  Future<BannerAd> loadBannerAd(String adUnitId) async {
    final completer = Completer<BannerAd>();
    bool isDisposed = false;

    final ad = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!isDisposed && !completer.isCompleted) {
            completer.complete(ad as BannerAd);
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (!isDisposed) {
            isDisposed = true;
            ad.dispose();
            if (!completer.isCompleted) {
              completer.completeError(error);
            }
          }
        },
        onAdImpression: (ad) {
          // Impression recorded
        },
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {
          // Paid event recorded
        },
      ),
    );

    ad.load();
    return completer.future;
  }

  @override
  Future<InterstitialAd> loadInterstitialAd(String adUnitId) async {
    final completer = Completer<InterstitialAd>();

    await InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          completer.complete(ad);
        },
        onAdFailedToLoad: (error) {
          completer.completeError(error);
        },
      ),
    );

    return completer.future;
  }

  @override
  void dispose() {
    // 必要に応じてクリーンアップ処理
  }
}
