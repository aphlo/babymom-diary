import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:babymom_diary/src/features/feeding_table_settings/domain/entities/feeding_table_settings.dart';

part 'feeding_table_settings_state.freezed.dart';

@freezed
sealed class FeedingTableSettingsState with _$FeedingTableSettingsState {
  const factory FeedingTableSettingsState({
    /// 表示するカテゴリの順序付きリスト
    @Default([]) List<FeedingTableCategory> visibleCategories,

    /// 非表示のカテゴリリスト
    @Default([]) List<FeedingTableCategory> hiddenCategories,

    /// ローディング中かどうか
    @Default(true) bool isLoading,

    /// 保存中かどうか
    @Default(false) bool isSaving,
  }) = _FeedingTableSettingsState;

  factory FeedingTableSettingsState.initial() =>
      const FeedingTableSettingsState();

  factory FeedingTableSettingsState.fromSettings(
      FeedingTableSettings settings) {
    final visible = settings.visibleCategories;
    final hidden =
        FeedingTableCategory.values.where((c) => !visible.contains(c)).toList();
    return FeedingTableSettingsState(
      visibleCategories: visible,
      hiddenCategories: hidden,
      isLoading: false,
    );
  }
}
