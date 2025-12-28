import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_config.freezed.dart';

@freezed
sealed class AdConfig with _$AdConfig {
  const factory AdConfig({
    required String bannerAdUnitId,
    required bool isTestMode,
  }) = _AdConfig;

  static AdConfig test() {
    return const AdConfig(
      bannerAdUnitId: 'ca-app-pub-3940256099942544/6300978111', // Android
      isTestMode: true,
    );
  }

  static AdConfig production({
    required String bannerAdUnitId,
  }) {
    return AdConfig(
      bannerAdUnitId: bannerAdUnitId,
      isTestMode: false,
    );
  }
}
