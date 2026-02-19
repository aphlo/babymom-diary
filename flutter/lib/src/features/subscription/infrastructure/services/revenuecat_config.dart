/// RevenueCatのflavor別API設定
class RevenueCatConfig {
  const RevenueCatConfig({
    required this.iosApiKey,
    required this.androidApiKey,
  });

  final String iosApiKey;
  final String androidApiKey;

  /// STG環境用（RevenueCatダッシュボードで設定したAPIキーに差し替え）
  static const stg = RevenueCatConfig(
    iosApiKey: 'appl_STG_KEY',
    androidApiKey: 'goog_STG_KEY',
  );

  /// 本番環境用（RevenueCatダッシュボードで設定したAPIキーに差し替え）
  static const prod = RevenueCatConfig(
    iosApiKey: 'appl_PROD_KEY',
    androidApiKey: 'goog_PROD_KEY',
  );
}
