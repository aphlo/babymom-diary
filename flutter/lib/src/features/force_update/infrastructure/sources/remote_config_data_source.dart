import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigDataSource {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigDataSource(this._remoteConfig);

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      // デバッグビルドでは即座にフェッチ、リリースビルドでは1時間間隔
      minimumFetchInterval:
          kDebugMode ? Duration.zero : const Duration(hours: 1),
    ));
    await _remoteConfig.setDefaults({
      'minimum_app_version_ios': '1.0.0',
      'minimum_app_version_android': '1.0.0',
      'force_update_message': 'アプリを更新してください',
      'store_url_ios': 'https://apps.apple.com/app/idXXXXXXXXXX',
      'store_url_android':
          'https://play.google.com/store/apps/details?id=com.aphlo.babymom_diary',
    });
    await _remoteConfig.fetchAndActivate();
  }

  String getMinimumVersion(TargetPlatform platform) {
    final key = platform == TargetPlatform.iOS
        ? 'minimum_app_version_ios'
        : 'minimum_app_version_android';
    return _remoteConfig.getString(key);
  }

  String getMessage() => _remoteConfig.getString('force_update_message');

  String getStoreUrl(TargetPlatform platform) {
    final key =
        platform == TargetPlatform.iOS ? 'store_url_ios' : 'store_url_android';
    return _remoteConfig.getString(key);
  }
}
