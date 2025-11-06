import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  /// 現在のフレーバーを取得
  static const String _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'local');

  /// localフレーバーかどうか
  static bool get isLocalFlavor => _flavor == 'local';

  /// バナー広告ユニットIDを取得
  /// localフレーバー: テスト広告ID
  /// prodフレーバー: 本番広告ID
  static String getBannerAdUnitId() {
    if (isLocalFlavor) {
      // テスト用広告ユニットID
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }

    // 本番用広告ユニットID
    return Platform.isAndroid
        ? 'ca-app-pub-6548153014267210/2709890019'
        : 'ca-app-pub-6548153014267210/8481091445';
  }

  /// インタースティシャル広告ユニットIDを取得
  /// localフレーバー: テスト広告ID
  /// prodフレーバー: 本番広告ID
  static String getInterstitialAdUnitId() {
    if (isLocalFlavor) {
      // テスト用広告ユニットID
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }

    // 本番用広告ユニットID（現在はバナーと同じIDを使用）
    return Platform.isAndroid
        ? 'ca-app-pub-6548153014267210/2709890019'
        : 'ca-app-pub-6548153014267210/8481091445';
  }
}
