/// RevenueCatのflavor別API設定
class RevenueCatConfig {
  const RevenueCatConfig({
    required this.iosApiKey,
    required this.androidApiKey,
  });

  final String iosApiKey;
  final String androidApiKey;

  /// STG環境用
  static const stg = RevenueCatConfig(
    iosApiKey: 'appl_lBCNGpvzWigLQyUdRKFLqRgpcYt',
    androidApiKey: 'goog_MJSCUwAyzwIeQlZVxoFsHYkMgBy',
  );

  /// 本番環境用
  static const prod = RevenueCatConfig(
    iosApiKey: 'appl_fbExLydQFNBsAOJBeZXdASOtOUp',
    androidApiKey: 'goog_REMdpoWGKkDfKrOgpkRiwPoEbd',
  );
}
