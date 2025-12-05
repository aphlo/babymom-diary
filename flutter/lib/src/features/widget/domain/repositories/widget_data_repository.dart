import '../entities/widget_data.dart';
import '../entities/widget_record.dart';
import '../entities/widget_settings.dart';

/// ウィジェットデータリポジトリのインターフェース
abstract class WidgetDataRepository {
  /// ウィジェットデータを取得
  Future<WidgetData> getWidgetData();

  /// ウィジェットデータを保存
  Future<void> saveWidgetData(WidgetData data);

  /// ウィジェット設定を取得
  Future<WidgetSettings> getWidgetSettings();

  /// ウィジェット設定を保存
  Future<void> saveWidgetSettings(WidgetSettings settings);

  /// 特定の子供の記録を更新
  Future<void> updateChildRecords(String childId, List<WidgetRecord> records);

  /// 選択中の子供IDを更新
  Future<void> updateSelectedChildId(String childId);

  /// ウィジェットを更新通知
  Future<void> notifyWidgetUpdate();
}
