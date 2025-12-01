import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

/// Firebase Remote Config からアプリ設定を取得するデータソース。
///
/// 強制アップデートに必要な最小バージョン、メッセージ、ストアURLを提供する。
class RemoteConfigDataSource {
  static const _keyMinimumVersionIos = 'minimum_app_version_ios';
  static const _keyMinimumVersionAndroid = 'minimum_app_version_android';
  static const _keyForceUpdateMessage = 'force_update_message';
  static const _keyStoreUrlIos = 'store_url_ios';
  static const _keyStoreUrlAndroid = 'store_url_android';

  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigDataSource(this._remoteConfig);

  /// Remote Config を初期化し、最新の設定をフェッチする。
  ///
  /// デバッグモードでは即座にフェッチ、リリースモードでは1時間間隔でキャッシュ。
  /// フェッチのタイムアウトは1分。
  ///
  /// ネットワークエラー等でフェッチに失敗した場合はデフォルト値が使用される。
  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval:
          kDebugMode ? Duration.zero : const Duration(hours: 1),
    ));
    await _remoteConfig.setDefaults({
      _keyMinimumVersionIos: '1.0.0',
      _keyMinimumVersionAndroid: '1.0.0',
      _keyForceUpdateMessage: 'アプリを更新してください',
      _keyStoreUrlIos: 'https://apps.apple.com/app/idXXXXXXXXXX',
      _keyStoreUrlAndroid:
          'https://play.google.com/store/apps/details?id=com.aphlo.babymom_diary',
    });
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Failed to fetch remote config: $e');
    }
  }

  /// 指定プラットフォームの最小必須バージョンを取得する。
  String getMinimumVersion(TargetPlatform platform) {
    final key = platform == TargetPlatform.iOS
        ? _keyMinimumVersionIos
        : _keyMinimumVersionAndroid;
    return _remoteConfig.getString(key);
  }

  /// 強制アップデート時に表示するメッセージを取得する。
  String getMessage() => _remoteConfig.getString(_keyForceUpdateMessage);

  /// 指定プラットフォームのストアURLを取得する。
  String getStoreUrl(TargetPlatform platform) {
    final key =
        platform == TargetPlatform.iOS ? _keyStoreUrlIos : _keyStoreUrlAndroid;
    return _remoteConfig.getString(key);
  }
}
