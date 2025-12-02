import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AdMobService {
  static bool _mobileAdsInitialized = false;
  static bool _attRequested = false;

  /// MobileAds SDKの初期化（main関数で呼ぶ）
  static Future<void> initializeMobileAds() async {
    if (_mobileAdsInitialized) return;

    await MobileAds.instance.initialize();
    _mobileAdsInitialized = true;
    debugPrint('AdMob: MobileAds SDK initialized');
  }

  /// ATT許可リクエスト（最初の画面表示後に呼ぶ）
  static Future<void> requestATTPermission() async {
    if (_attRequested) {
      debugPrint('AdMob: ATT permission already requested');
      return;
    }

    _attRequested = true;

    // iOS: App Tracking Transparencyの許可をリクエスト
    if (Platform.isIOS) {
      try {
        final status =
            await AppTrackingTransparency.trackingAuthorizationStatus;
        debugPrint('AdMob: Current ATT status: $status');

        // まだ許可をリクエストしていない場合はリクエスト
        if (status == TrackingStatus.notDetermined) {
          debugPrint('AdMob: Requesting ATT permission...');
          final newStatus =
              await AppTrackingTransparency.requestTrackingAuthorization();
          debugPrint('AdMob: ATT permission result: $newStatus');

          // ステータスに応じたメッセージ
          switch (newStatus) {
            case TrackingStatus.authorized:
              debugPrint('AdMob: ✅ Personalized ads enabled');
              break;
            case TrackingStatus.denied:
            case TrackingStatus.restricted:
              debugPrint('AdMob: ℹ️  Non-personalized ads will be shown');
              break;
            case TrackingStatus.notDetermined:
              debugPrint('AdMob: ⚠️  ATT status not determined');
              break;
            case TrackingStatus.notSupported:
              debugPrint('AdMob: ℹ️  ATT not supported on this device');
              break;
          }
        } else if (status == TrackingStatus.denied ||
            status == TrackingStatus.restricted) {
          debugPrint(
              'AdMob: ℹ️  ATT denied/restricted - Non-personalized ads will be shown');
        } else if (status == TrackingStatus.authorized) {
          debugPrint('AdMob: ✅ ATT authorized - Personalized ads enabled');
        }
      } catch (e) {
        debugPrint('AdMob: Failed to request ATT permission: $e');
        debugPrint('AdMob: ℹ️  Falling back to non-personalized ads');
      }
    }
  }

  /// 現在のフレーバーを取得
  static const String _flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'prod');

  /// テスト広告を使用するフレーバーかどうか
  static bool get isTestAdFlavor => _flavor == 'stg';

  /// バナー広告ユニットIDを取得
  /// stgフレーバー: テスト広告ID
  /// prodフレーバー: 本番広告ID
  static String getBannerAdUnitId() {
    if (isTestAdFlavor) {
      // テスト用広告ユニットID
      final adUnitId = Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
      return adUnitId;
    }

    // 本番用広告ユニットID
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-6548153014267210/2709890019'
        : 'ca-app-pub-6548153014267210/8481091445';
    return adUnitId;
  }
}
