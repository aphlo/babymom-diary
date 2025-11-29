import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/ad_config.dart';
import '../../domain/repositories/ad_repository.dart';
import '../../infrastructure/repositories/ad_repository_impl.dart';
import '../../infrastructure/services/admob_service.dart';

part 'ad_providers.g.dart';

// AdRepositoryプロバイダー
@Riverpod(keepAlive: true)
AdRepository adRepository(Ref ref) {
  return AdRepositoryImpl();
}

// AdConfigプロバイダー（フレーバーに応じて自動切り替え）
@Riverpod(keepAlive: true)
AdConfig adConfig(Ref ref) {
  return AdConfig(
    bannerAdUnitId: AdMobService.getBannerAdUnitId(),
    isTestMode: AdMobService.isLocalFlavor,
  );
}
