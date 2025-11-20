import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ad_config.dart';
import '../../domain/repositories/ad_repository.dart';
import '../../infrastructure/repositories/ad_repository_impl.dart';
import '../../infrastructure/services/admob_service.dart';

// AdRepositoryプロバイダー
final adRepositoryProvider = Provider<AdRepository>((ref) {
  return AdRepositoryImpl();
});

// AdConfigプロバイダー（フレーバーに応じて自動切り替え）
final adConfigProvider = Provider<AdConfig>((ref) {
  return AdConfig(
    bannerAdUnitId: AdMobService.getBannerAdUnitId(),
    interstitialAdUnitId: AdMobService.getInterstitialAdUnitId(),
    isTestMode: AdMobService.isLocalFlavor,
  );
});
