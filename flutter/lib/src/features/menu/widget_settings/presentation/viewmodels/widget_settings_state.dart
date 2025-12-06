import 'package:flutter/foundation.dart';

import '../../../../widget/domain/entities/widget_settings.dart';
import '../models/widget_record_category.dart';

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

  /// 直近の記録表示で選択可能なカテゴリ（現在選択中のものを除く）
  List<WidgetRecordCategory> get availableDisplayCategories =>
      WidgetRecordCategory.values
          .where((c) => !displayCategories.contains(c))
          .toList();

  /// クイックアクションで選択可能なカテゴリ（現在選択中のものを除く）
  List<WidgetRecordCategory> get availableQuickActionCategories =>
      WidgetRecordCategory.values
          .where((c) => !quickActionCategories.contains(c))
          .toList();

  /// 直近の記録表示のデフォルト値
  static const List<WidgetRecordCategory> defaultDisplayCategories = [
    WidgetRecordCategory.breast,
    WidgetRecordCategory.formula,
    WidgetRecordCategory.pee,
  ];

  /// クイックアクションのデフォルト値
  static const List<WidgetRecordCategory> defaultQuickActionCategories = [
    WidgetRecordCategory.breast,
    WidgetRecordCategory.formula,
    WidgetRecordCategory.pee,
    WidgetRecordCategory.poop,
    WidgetRecordCategory.temperature,
  ];

  factory WidgetSettingsState.initial() {
    return const WidgetSettingsState(
      displayCategories: [],
      quickActionCategories: [],
      isLoading: true,
    );
  }

  factory WidgetSettingsState.fromWidgetSettings(WidgetSettings settings) {
    var displayCategories = settings.mediumWidget.displayRecordTypes
        .map((t) => WidgetRecordCategoryExtension.fromRecordType(t))
        .toSet()
        .toList();

    var quickActionCategories = settings.mediumWidget.quickActionTypes
        .map((t) => WidgetRecordCategoryExtension.fromRecordType(t))
        .toSet()
        .toList();

    // 項目数が足りない場合はデフォルト値で補完
    if (displayCategories.length < maxDisplayCategories) {
      displayCategories = _fillWithDefaults(
        displayCategories,
        defaultDisplayCategories,
        maxDisplayCategories,
      );
    }
    if (quickActionCategories.length < maxQuickActionCategories) {
      quickActionCategories = _fillWithDefaults(
        quickActionCategories,
        defaultQuickActionCategories,
        maxQuickActionCategories,
      );
    }

    return WidgetSettingsState(
      displayCategories: displayCategories,
      quickActionCategories: quickActionCategories,
    );
  }

  /// 現在のリストをデフォルト値で補完する
  static List<WidgetRecordCategory> _fillWithDefaults(
    List<WidgetRecordCategory> current,
    List<WidgetRecordCategory> defaults,
    int maxCount,
  ) {
    final result = List<WidgetRecordCategory>.from(current);
    for (final category in defaults) {
      if (result.length >= maxCount) break;
      if (!result.contains(category)) {
        result.add(category);
      }
    }
    // デフォルトでも足りない場合は全カテゴリから補完
    for (final category in WidgetRecordCategory.values) {
      if (result.length >= maxCount) break;
      if (!result.contains(category)) {
        result.add(category);
      }
    }
    return result;
  }
}
