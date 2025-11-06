import 'package:meta/meta.dart';

@immutable
class AdConfig {
  final String bannerAdUnitId;
  final String interstitialAdUnitId;
  final bool isTestMode;

  const AdConfig({
    required this.bannerAdUnitId,
    required this.interstitialAdUnitId,
    required this.isTestMode,
  });

  factory AdConfig.test() {
    return const AdConfig(
      bannerAdUnitId: 'ca-app-pub-3940256099942544/6300978111', // Android
      interstitialAdUnitId: 'ca-app-pub-3940256099942544/1033173712',
      isTestMode: true,
    );
  }

  factory AdConfig.production({
    required String bannerAdUnitId,
    required String interstitialAdUnitId,
  }) {
    return AdConfig(
      bannerAdUnitId: bannerAdUnitId,
      interstitialAdUnitId: interstitialAdUnitId,
      isTestMode: false,
    );
  }
}
