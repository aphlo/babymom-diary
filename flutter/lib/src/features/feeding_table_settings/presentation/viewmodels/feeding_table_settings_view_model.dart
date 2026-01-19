import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/feeding_table_settings/domain/entities/feeding_table_settings.dart';
import 'package:babymom_diary/src/features/feeding_table_settings/infrastructure/repositories/feeding_table_settings_repository_impl.dart';
import 'feeding_table_settings_state.dart';

part 'feeding_table_settings_view_model.g.dart';

@riverpod
class FeedingTableSettingsViewModel extends _$FeedingTableSettingsViewModel {
  @override
  FeedingTableSettingsState build() {
    _loadSettings();
    return FeedingTableSettingsState.initial();
  }

  Future<void> _loadSettings() async {
    final repository = ref.read(feedingTableSettingsRepositoryProvider);
    final settings = await repository.getSettings();
    state = FeedingTableSettingsState.fromSettings(settings);
  }

  /// カテゴリの表示/非表示を切り替える
  Future<void> toggleCategory(FeedingTableCategory category) async {
    if (state.visibleCategories.contains(category)) {
      // 最低1つは表示を維持
      if (state.visibleCategories.length <= 1) {
        return;
      }
      // 非表示にする
      final newVisible =
          state.visibleCategories.where((c) => c != category).toList();
      final newHidden = [...state.hiddenCategories, category];
      state = state.copyWith(
        visibleCategories: newVisible,
        hiddenCategories: newHidden,
      );
    } else {
      // 表示にする（末尾に追加）
      final newVisible = [...state.visibleCategories, category];
      final newHidden =
          state.hiddenCategories.where((c) => c != category).toList();
      state = state.copyWith(
        visibleCategories: newVisible,
        hiddenCategories: newHidden,
      );
    }
    await _saveSettings();
  }

  /// 表示カテゴリの順序を変更する
  Future<void> reorderCategories(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final items = [...state.visibleCategories];
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = state.copyWith(visibleCategories: items);
    await _saveSettings();
  }

  Future<void> _saveSettings() async {
    state = state.copyWith(isSaving: true);
    try {
      final repository = ref.read(feedingTableSettingsRepositoryProvider);
      final settings = FeedingTableSettings(
        visibleCategories: state.visibleCategories,
      );
      await repository.saveSettings(settings);
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
