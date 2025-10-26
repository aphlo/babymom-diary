import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';

/// カレンダー設定のリポジトリインターフェース
abstract class CalendarSettingsRepository {
  /// カレンダー設定を取得する
  Future<CalendarSettings> getSettings();

  /// カレンダー設定を保存する
  Future<void> saveSettings(CalendarSettings settings);

  /// カレンダー設定の変更を監視するストリーム
  Stream<CalendarSettings> watchSettings();
}
