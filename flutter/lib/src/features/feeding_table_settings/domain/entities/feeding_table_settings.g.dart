// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_table_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedingTableSettings _$FeedingTableSettingsFromJson(
        Map<String, dynamic> json) =>
    _FeedingTableSettings(
      visibleCategories: (json['visibleCategories'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$FeedingTableCategoryEnumMap, e))
              .toList() ??
          const [
            FeedingTableCategory.nursing,
            FeedingTableCategory.formula,
            FeedingTableCategory.pump,
            FeedingTableCategory.babyFood,
            FeedingTableCategory.pee,
            FeedingTableCategory.poop,
            FeedingTableCategory.temperature,
            FeedingTableCategory.other
          ],
    );

Map<String, dynamic> _$FeedingTableSettingsToJson(
        _FeedingTableSettings instance) =>
    <String, dynamic>{
      'visibleCategories': instance.visibleCategories
          .map((e) => _$FeedingTableCategoryEnumMap[e]!)
          .toList(),
    };

const _$FeedingTableCategoryEnumMap = {
  FeedingTableCategory.nursing: 'nursing',
  FeedingTableCategory.formula: 'formula',
  FeedingTableCategory.pump: 'pump',
  FeedingTableCategory.babyFood: 'babyFood',
  FeedingTableCategory.pee: 'pee',
  FeedingTableCategory.poop: 'poop',
  FeedingTableCategory.temperature: 'temperature',
  FeedingTableCategory.other: 'other',
};
