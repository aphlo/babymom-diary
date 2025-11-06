import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../application/providers/ad_providers.dart';

class InterstitialAdManager {
  final Ref ref;
  InterstitialAd? _interstitialAd;
  bool _isLoading = false;

  InterstitialAdManager(this.ref);

  Future<void> load() async {
    if (_isLoading || _interstitialAd != null) return;

    _isLoading = true;
    final config = ref.read(adConfigProvider);
    final repository = ref.read(adRepositoryProvider);

    try {
      _interstitialAd = await repository.loadInterstitialAd(
        config.interstitialAdUnitId,
      );
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _interstitialAd = null;
          load(); // 次の広告をプリロード
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _interstitialAd = null;
        },
      );
    } catch (e) {
      // Failed to load ad
    } finally {
      _isLoading = false;
    }
  }

  Future<void> show() async {
    if (_interstitialAd != null) {
      await _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}

// プロバイダー
final interstitialAdManagerProvider = Provider<InterstitialAdManager>((ref) {
  final manager = InterstitialAdManager(ref);
  ref.onDispose(() => manager.dispose());
  return manager;
});
