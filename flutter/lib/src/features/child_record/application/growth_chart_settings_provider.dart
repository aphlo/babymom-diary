import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/preferences/shared_preferences_provider.dart';
import '../infrastructure/growth_chart_settings_storage.dart';

final growthChartSettingsStorageProvider =
    Provider<GrowthChartSettingsStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return GrowthChartSettingsStorage(prefs);
});

/// 成長曲線の設定を管理するStateNotifier
class GrowthChartSettingsNotifier extends StateNotifier<bool> {
  GrowthChartSettingsNotifier(this._storage)
      : super(_storage.getUseCorrectedAge());

  final GrowthChartSettingsStorage _storage;

  /// 修正月齢で表示する設定を切り替え
  Future<void> setUseCorrectedAge(bool value) async {
    await _storage.setUseCorrectedAge(value);
    state = value;
  }
}

final growthChartSettingsProvider =
    StateNotifierProvider<GrowthChartSettingsNotifier, bool>((ref) {
  final storage = ref.watch(growthChartSettingsStorageProvider);
  return GrowthChartSettingsNotifier(storage);
});
