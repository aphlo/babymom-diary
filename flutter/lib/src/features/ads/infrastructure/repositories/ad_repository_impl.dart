import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../domain/repositories/ad_repository.dart';

class AdRepositoryImpl implements AdRepository {
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
  void dispose() {
    // 必要に応じてクリーンアップ処理
  }
}
