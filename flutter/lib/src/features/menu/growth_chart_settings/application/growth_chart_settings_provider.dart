import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/preferences/shared_preferences_provider.dart';
import '../infrastructure/growth_chart_settings_storage.dart';

part 'growth_chart_settings_provider.g.dart';

@riverpod
GrowthChartSettingsStorage growthChartSettingsStorage(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return GrowthChartSettingsStorage(prefs);
}

/// 成長曲線の設定を管理するNotifier
@Riverpod(keepAlive: true)
class GrowthChartSettings extends _$GrowthChartSettings {
  @override
  bool build() {
    final storage = ref.watch(growthChartSettingsStorageProvider);
    return storage.getUseCorrectedAge();
  }

  /// 修正月齢で表示する設定を切り替え
  Future<void> setUseCorrectedAge(bool value) async {
    final storage = ref.read(growthChartSettingsStorageProvider);
    await storage.setUseCorrectedAge(value);
    state = value;
  }
}
