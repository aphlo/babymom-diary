import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../widget/application/providers/widget_providers.dart';
import '../../../../widget/domain/entities/widget_settings.dart';
import '../models/widget_record_category.dart';

part 'widget_settings_view_model.g.dart';

/// ウィジェット設定画面の状態
@immutable
class WidgetSettingsState {
  const WidgetSettingsState({
    required this.displayCategories,
    required this.quickActionCategories,
    this.isLoading = false,
    this.isSaving = false,
  });

  /// 直近の記録表示カテゴリ（最大3つ）
  final List<WidgetRecordCategory> displayCategories;

  /// クイックアクションカテゴリ（最大5つ）
  final List<WidgetRecordCategory> quickActionCategories;

  /// 読み込み中かどうか
  final bool isLoading;

  /// 保存中かどうか
  final bool isSaving;

  /// 直近の記録表示の最大数
  static const int maxDisplayCategories = 3;

  /// クイックアクションの最大数
  static const int maxQuickActionCategories = 5;

  WidgetSettingsState copyWith({
    List<WidgetRecordCategory>? displayCategories,
    List<WidgetRecordCategory>? quickActionCategories,
    bool? isLoading,
    bool? isSaving,
  }) {
    return WidgetSettingsState(
      displayCategories: displayCategories ?? this.displayCategories,
      quickActionCategories:
          quickActionCategories ?? this.quickActionCategories,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  /// 直近の記録表示に追加可能かどうか
  bool get canAddDisplayCategory =>
      displayCategories.length < maxDisplayCategories;

  /// クイックアクションに追加可能かどうか
  bool get canAddQuickAction =>
      quickActionCategories.length < maxQuickActionCategories;

  /// 直近の記録表示で選択可能なカテゴリ
  List<WidgetRecordCategory> get availableDisplayCategories =>
      WidgetRecordCategory.values
          .where((c) => !displayCategories.contains(c))
          .toList();

  /// クイックアクションで選択可能なカテゴリ
  List<WidgetRecordCategory> get availableQuickActionCategories =>
      WidgetRecordCategory.values
          .where((c) => !quickActionCategories.contains(c))
          .toList();

  factory WidgetSettingsState.initial() {
    return const WidgetSettingsState(
      displayCategories: [],
      quickActionCategories: [],
      isLoading: true,
    );
  }

  factory WidgetSettingsState.fromWidgetSettings(WidgetSettings settings) {
    return WidgetSettingsState(
      displayCategories: settings.mediumWidget.displayRecordTypes
          .map((t) => WidgetRecordCategoryExtension.fromRecordType(t))
          .toSet()
          .toList(),
      quickActionCategories: settings.mediumWidget.quickActionTypes
          .map((t) => WidgetRecordCategoryExtension.fromRecordType(t))
          .toSet()
          .toList(),
    );
  }
}

@riverpod
class WidgetSettingsViewModel extends _$WidgetSettingsViewModel {
  @override
  WidgetSettingsState build() {
    _loadSettings();
    return WidgetSettingsState.initial();
  }

  Future<void> _loadSettings() async {
    final settingsAsync = await ref.read(widgetSettingsProvider.future);
    state = WidgetSettingsState.fromWidgetSettings(settingsAsync);
  }

  /// 直近の記録表示にカテゴリを追加
  void addDisplayCategory(WidgetRecordCategory category) {
    if (!state.canAddDisplayCategory) return;
    if (state.displayCategories.contains(category)) return;

    state = state.copyWith(
      displayCategories: [...state.displayCategories, category],
    );
    _saveSettings();
  }

  /// 直近の記録表示からカテゴリを削除
  void removeDisplayCategory(WidgetRecordCategory category) {
    state = state.copyWith(
      displayCategories:
          state.displayCategories.where((c) => c != category).toList(),
    );
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

  /// クイックアクションにカテゴリを追加
  void addQuickActionCategory(WidgetRecordCategory category) {
    if (!state.canAddQuickAction) return;
    if (state.quickActionCategories.contains(category)) return;

    state = state.copyWith(
      quickActionCategories: [...state.quickActionCategories, category],
    );
    _saveSettings();
  }

  /// クイックアクションからカテゴリを削除
  void removeQuickActionCategory(WidgetRecordCategory category) {
    state = state.copyWith(
      quickActionCategories:
          state.quickActionCategories.where((c) => c != category).toList(),
    );
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
