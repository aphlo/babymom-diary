import 'package:meta/meta.dart';

@immutable
class AdConfig {
  final String bannerAdUnitId;
  final bool isTestMode;

  const AdConfig({
    required this.bannerAdUnitId,
    required this.isTestMode,
  });

  factory AdConfig.test() {
    return const AdConfig(
      bannerAdUnitId: 'ca-app-pub-3940256099942544/6300978111', // Android
      isTestMode: true,
    );
  }

  factory AdConfig.production({
    required String bannerAdUnitId,
  }) {
    return AdConfig(
      bannerAdUnitId: bannerAdUnitId,
      isTestMode: false,
    );
  }
}
