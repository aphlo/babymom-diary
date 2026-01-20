import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:babymom_diary/src/features/child_record/domain/value/record_type.dart';

part 'feeding_table_settings.freezed.dart';
part 'feeding_table_settings.g.dart';

/// 授乳表のカテゴリ（列）
enum FeedingTableCategory {
  nursing, // 授乳（breastRight + breastLeft）
  formula, // ミルク
  pump, // 搾母乳
  babyFood, // 離乳食
  pee, // 尿
  poop, // 便
  temperature, // 体温
  other, // その他
}

extension FeedingTableCategoryX on FeedingTableCategory {
  String get label => switch (this) {
        FeedingTableCategory.nursing => '授乳',
        FeedingTableCategory.formula => 'ミルク',
        FeedingTableCategory.pump => '搾母乳',
        FeedingTableCategory.babyFood => '離乳食',
        FeedingTableCategory.pee => '尿',
        FeedingTableCategory.poop => '便',
        FeedingTableCategory.temperature => '体温',
        FeedingTableCategory.other => 'その他',
      };

  /// このカテゴリに対応するRecordType一覧
  List<RecordType> get recordTypes => switch (this) {
        FeedingTableCategory.nursing => [
            RecordType.breastRight,
            RecordType.breastLeft
          ],
        FeedingTableCategory.formula => [RecordType.formula],
        FeedingTableCategory.pump => [RecordType.pump],
        FeedingTableCategory.babyFood => [RecordType.babyFood],
        FeedingTableCategory.pee => [RecordType.pee],
        FeedingTableCategory.poop => [RecordType.poop],
        FeedingTableCategory.temperature => [RecordType.temperature],
        FeedingTableCategory.other => [RecordType.other],
      };

  /// RecordTypeからカテゴリを取得
  static FeedingTableCategory? fromRecordType(RecordType type) =>
      switch (type) {
        RecordType.breastRight ||
        RecordType.breastLeft =>
          FeedingTableCategory.nursing,
        RecordType.formula => FeedingTableCategory.formula,
        RecordType.pump => FeedingTableCategory.pump,
        RecordType.babyFood => FeedingTableCategory.babyFood,
        RecordType.pee => FeedingTableCategory.pee,
        RecordType.poop => FeedingTableCategory.poop,
        RecordType.temperature => FeedingTableCategory.temperature,
        RecordType.other => FeedingTableCategory.other,
      };

  /// WidgetRecordCategory名からFeedingTableCategoryを取得
  /// Widget設定との連携で使用
  static FeedingTableCategory? fromWidgetCategoryName(String name) =>
      switch (name) {
        'breast' => FeedingTableCategory.nursing,
        'formula' => FeedingTableCategory.formula,
        'pump' => FeedingTableCategory.pump,
        'babyFood' => FeedingTableCategory.babyFood,
        'pee' => FeedingTableCategory.pee,
        'poop' => FeedingTableCategory.poop,
        'temperature' => FeedingTableCategory.temperature,
        'other' => FeedingTableCategory.other,
        _ => null,
      };
}

/// 授乳表の設定
@freezed
abstract class FeedingTableSettings with _$FeedingTableSettings {
  const FeedingTableSettings._();

  const factory FeedingTableSettings({
    /// 表示するカテゴリの順序付きリスト
    /// リストに含まれるカテゴリのみ表示される
    @Default([
      FeedingTableCategory.nursing,
      FeedingTableCategory.formula,
      FeedingTableCategory.pump,
      FeedingTableCategory.babyFood,
      FeedingTableCategory.pee,
      FeedingTableCategory.poop,
      FeedingTableCategory.temperature,
      FeedingTableCategory.other,
    ])
    List<FeedingTableCategory> visibleCategories,
  }) = _FeedingTableSettings;

  factory FeedingTableSettings.fromJson(Map<String, dynamic> json) =>
      _$FeedingTableSettingsFromJson(json);

  /// 指定したRecordTypeが表示対象かどうか
  bool isRecordTypeVisible(RecordType type) {
    final category = FeedingTableCategoryX.fromRecordType(type);
    return category != null && visibleCategories.contains(category);
  }

  /// 全カテゴリ（順序変更・表示/非表示切り替えUI用）
  static List<FeedingTableCategory> get allCategories =>
      FeedingTableCategory.values;
}
