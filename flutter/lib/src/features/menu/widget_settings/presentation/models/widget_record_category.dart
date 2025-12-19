import '../../../../child_record/domain/value/record_type.dart';

/// ウィジェットで選択可能な記録カテゴリ
///
/// breastRight/breastLeftは「授乳」として1つにまとめる
enum WidgetRecordCategory {
  breast, // breastRight/breastLeftをまとめる
  formula,
  pump,
  pee,
  poop,
  temperature,
  other,
}

extension WidgetRecordCategoryExtension on WidgetRecordCategory {
  String get label => switch (this) {
        WidgetRecordCategory.breast => '授乳',
        WidgetRecordCategory.formula => 'ミルク',
        WidgetRecordCategory.pump => '搾母乳',
        WidgetRecordCategory.pee => '尿',
        WidgetRecordCategory.poop => '便',
        WidgetRecordCategory.temperature => '体温',
        WidgetRecordCategory.other => 'その他',
      };

  String iconAssetPath({required bool isDark}) {
    return toRecordType().iconAssetPath(isDark: isDark);
  }

  /// RecordTypeに変換（保存用）
  /// breastはbreastLeftとして保存（クイックアクションで使用）
  RecordType toRecordType() => switch (this) {
        WidgetRecordCategory.breast => RecordType.breastLeft,
        WidgetRecordCategory.formula => RecordType.formula,
        WidgetRecordCategory.pump => RecordType.pump,
        WidgetRecordCategory.pee => RecordType.pee,
        WidgetRecordCategory.poop => RecordType.poop,
        WidgetRecordCategory.temperature => RecordType.temperature,
        WidgetRecordCategory.other => RecordType.other,
      };

  /// RecordTypeからカテゴリに変換
  static WidgetRecordCategory fromRecordType(RecordType type) => switch (type) {
        RecordType.breastRight ||
        RecordType.breastLeft =>
          WidgetRecordCategory.breast,
        RecordType.formula => WidgetRecordCategory.formula,
        RecordType.pump => WidgetRecordCategory.pump,
        RecordType.pee => WidgetRecordCategory.pee,
        RecordType.poop => WidgetRecordCategory.poop,
        RecordType.temperature => WidgetRecordCategory.temperature,
        RecordType.other => WidgetRecordCategory.other,
      };
}
