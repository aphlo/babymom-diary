import 'package:shared_preferences/shared_preferences.dart';

/// 成長曲線の設定をローカルに保存・読み込みするクラス
class GrowthChartSettingsStorage {
  GrowthChartSettingsStorage(this._prefs);

  final SharedPreferences _prefs;

  static const _keyUseCorrectedAge = 'growth_chart_use_corrected_age';

  /// 修正月齢で表示するか
  bool getUseCorrectedAge() {
    return _prefs.getBool(_keyUseCorrectedAge) ?? false;
  }

  /// 修正月齢で表示する設定を保存
  Future<void> setUseCorrectedAge(bool value) async {
    await _prefs.setBool(_keyUseCorrectedAge, value);
  }
}
