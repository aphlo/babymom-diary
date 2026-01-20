import '../entities/feeding_table_settings.dart';

/// 授乳表設定のリポジトリインターフェース
abstract class FeedingTableSettingsRepository {
  /// 設定を取得する
  Future<FeedingTableSettings> getSettings();

  /// 設定を保存する
  Future<void> saveSettings(FeedingTableSettings settings);

  /// 設定の変更を監視する
  Stream<FeedingTableSettings> watchSettings();
}
