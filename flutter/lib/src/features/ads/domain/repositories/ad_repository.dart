import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdRepository {
  Future<void> initialize();
  Future<BannerAd> loadBannerAd(String adUnitId);
  Future<InterstitialAd> loadInterstitialAd(String adUnitId);
  void dispose();
}
