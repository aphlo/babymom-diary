import '../entities/vaccine_visibility_settings.dart';

/// ワクチン表示設定のリポジトリインターフェース
abstract class VaccineVisibilitySettingsRepository {
  /// 世帯のワクチン表示設定を取得
  ///
  /// 設定が存在しない場合は、空のマップを持つデフォルト設定を返します。
  Future<VaccineVisibilitySettings> getSettings({
    required String householdId,
  });

  /// ワクチン表示設定を更新
  ///
  /// Firestoreの`households/{householdId}`ドキュメントの
  /// `vaccineVisibilitySettings`フィールドを更新します。
  Future<void> updateSettings({
    required VaccineVisibilitySettings settings,
  });

  /// ワクチン表示設定の変更をリアルタイムで監視
  Stream<VaccineVisibilitySettings> watchSettings({
    required String householdId,
  });
}
