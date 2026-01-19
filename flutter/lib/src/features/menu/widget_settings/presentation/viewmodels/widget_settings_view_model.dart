import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../feeding_table_settings/application/providers/feeding_table_settings_providers.dart';
import '../../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../../../../widget/application/providers/widget_providers.dart';
import '../../../../widget/domain/entities/widget_settings.dart';
import '../models/widget_record_category.dart';
import 'widget_settings_state.dart';

part 'widget_settings_view_model.g.dart';

@riverpod
class WidgetSettingsViewModel extends _$WidgetSettingsViewModel {
  @override
  WidgetSettingsState build() {
    _loadSettings();
    // 授乳表設定の変更を監視して非表示カテゴリを更新
    ref.listen(feedingTableSettingsStreamProvider, (_, next) {
      _updateHiddenCategories(next.value);
    });
    return WidgetSettingsState.initial();
  }

  Future<void> _loadSettings() async {
    final settingsAsync = await ref.read(widgetSettingsProvider.future);
    final feedingSettings = await ref.read(feedingTableSettingsProvider.future);
    final hiddenCategories = _computeHiddenCategories(feedingSettings);
    state = WidgetSettingsState.fromWidgetSettings(settingsAsync)
        .copyWith(hiddenCategories: hiddenCategories);
  }

  /// 授乳表設定から非表示カテゴリを計算
  List<WidgetRecordCategory> _computeHiddenCategories(
      FeedingTableSettings feedingSettings) {
    final visibleFeedingCategories = feedingSettings.visibleCategories;
    return WidgetRecordCategory.values.where((widgetCategory) {
      final feedingCategory =
          FeedingTableCategoryX.fromWidgetCategoryName(widgetCategory.name);
      return feedingCategory != null &&
          !visibleFeedingCategories.contains(feedingCategory);
    }).toList();
  }

  /// 授乳表設定変更時に非表示カテゴリを更新
  void _updateHiddenCategories(FeedingTableSettings? feedingSettings) {
    if (feedingSettings == null) return;
    final hiddenCategories = _computeHiddenCategories(feedingSettings);
    state = state.copyWith(hiddenCategories: hiddenCategories);
  }

  /// 直近の記録表示のカテゴリを置き換え
  void replaceDisplayCategory(int index, WidgetRecordCategory newCategory) {
    if (index < 0 || index >= state.displayCategories.length) return;
    if (state.displayCategories.contains(newCategory)) return;

    final categories = List<WidgetRecordCategory>.from(state.displayCategories);
    categories[index] = newCategory;
    state = state.copyWith(displayCategories: categories);
    _saveSettings();
  }

  /// 直近の記録表示のカテゴリを並び替え
  void reorderDisplayCategories(int oldIndex, int newIndex) {
    final categories = List<WidgetRecordCategory>.from(state.displayCategories);
    if (newIndex > oldIndex) newIndex--;
    final item = categories.removeAt(oldIndex);
    categories.insert(newIndex, item);
    state = state.copyWith(displayCategories: categories);
    _saveSettings();
  }

  /// クイックアクションのカテゴリを置き換え
  void replaceQuickActionCategory(int index, WidgetRecordCategory newCategory) {
    if (index < 0 || index >= state.quickActionCategories.length) return;
    if (state.quickActionCategories.contains(newCategory)) return;

    final categories =
        List<WidgetRecordCategory>.from(state.quickActionCategories);
    categories[index] = newCategory;
    state = state.copyWith(quickActionCategories: categories);
    _saveSettings();
  }

  /// クイックアクションのカテゴリを並び替え
  void reorderQuickActionCategories(int oldIndex, int newIndex) {
    final categories =
        List<WidgetRecordCategory>.from(state.quickActionCategories);
    if (newIndex > oldIndex) newIndex--;
    final item = categories.removeAt(oldIndex);
    categories.insert(newIndex, item);
    state = state.copyWith(quickActionCategories: categories);
    _saveSettings();
  }

  Future<void> _saveSettings() async {
    state = state.copyWith(isSaving: true);

    final displayTypes =
        state.displayCategories.map((c) => c.toRecordType()).toList();
    final quickActionTypes =
        state.quickActionCategories.map((c) => c.toRecordType()).toList();

    final settings = MediumWidgetSettings(
      displayRecordTypes: displayTypes,
      quickActionTypes: quickActionTypes,
    );

    await ref
        .read(widgetSettingsProvider.notifier)
        .updateMediumWidgetSettings(settings);

    state = state.copyWith(isSaving: false);
  }
}
