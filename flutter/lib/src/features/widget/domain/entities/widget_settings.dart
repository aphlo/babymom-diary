import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../child_record/domain/value/record_type.dart';

part 'widget_settings.freezed.dart';

/// 横長ウィジェット（Medium）の設定
@Freezed(toJson: false, fromJson: false)
sealed class MediumWidgetSettings with _$MediumWidgetSettings {
  const MediumWidgetSettings._();

  /// 3列で表示する3種類のRecordType
  /// 下部に表示する5つのクイックアクション
  const factory MediumWidgetSettings({
    @Default([
      RecordType.breastRight,
      RecordType.formula,
      RecordType.pee,
    ])
    List<RecordType> displayRecordTypes,
    @Default([
      RecordType.breastLeft,
      RecordType.formula,
      RecordType.pee,
      RecordType.poop,
      RecordType.temperature,
    ])
    List<RecordType> quickActionTypes,
  }) = _MediumWidgetSettings;

  Map<String, dynamic> toJson() => {
        'displayRecordTypes': displayRecordTypes.map((t) => t.name).toList(),
        'quickActionTypes': quickActionTypes.map((t) => t.name).toList(),
      };

  factory MediumWidgetSettings.fromJson(Map<String, dynamic> json) {
    return MediumWidgetSettings(
      displayRecordTypes: (json['displayRecordTypes'] as List<dynamic>?)
              ?.map((t) => RecordType.values.byName(t as String))
              .toList() ??
          const [RecordType.breastRight, RecordType.formula, RecordType.pee],
      quickActionTypes: (json['quickActionTypes'] as List<dynamic>?)
              ?.map((t) => RecordType.values.byName(t as String))
              .toList() ??
          const [
            RecordType.breastLeft,
            RecordType.formula,
            RecordType.pee,
            RecordType.poop,
            RecordType.temperature,
          ],
    );
  }
}

/// 正方形ウィジェット（Small）の設定
@Freezed(toJson: false, fromJson: false)
sealed class SmallWidgetSettings with _$SmallWidgetSettings {
  const SmallWidgetSettings._();

  /// 表示するRecordType（nullで全種類）
  const factory SmallWidgetSettings({
    RecordType? filterRecordType,
  }) = _SmallWidgetSettings;

  /// filterRecordTypeをnullにクリアする
  SmallWidgetSettings clearFilter() =>
      const SmallWidgetSettings(filterRecordType: null);

  Map<String, dynamic> toJson() => {
        if (filterRecordType != null)
          'filterRecordType': filterRecordType!.name,
      };

  factory SmallWidgetSettings.fromJson(Map<String, dynamic> json) {
    final filterType = json['filterRecordType'] as String?;
    return SmallWidgetSettings(
      filterRecordType:
          filterType != null ? RecordType.values.byName(filterType) : null,
    );
  }
}

/// ウィジェット設定全体
@Freezed(toJson: false, fromJson: false)
sealed class WidgetSettings with _$WidgetSettings {
  const WidgetSettings._();

  const factory WidgetSettings({
    @Default(MediumWidgetSettings()) MediumWidgetSettings mediumWidget,
    @Default(SmallWidgetSettings()) SmallWidgetSettings smallWidget,
  }) = _WidgetSettings;

  Map<String, dynamic> toJson() => {
        'mediumWidget': mediumWidget.toJson(),
        'smallWidget': smallWidget.toJson(),
      };

  factory WidgetSettings.fromJson(Map<String, dynamic> json) {
    return WidgetSettings(
      mediumWidget: json['mediumWidget'] != null
          ? MediumWidgetSettings.fromJson(
              json['mediumWidget'] as Map<String, dynamic>)
          : const MediumWidgetSettings(),
      smallWidget: json['smallWidget'] != null
          ? SmallWidgetSettings.fromJson(
              json['smallWidget'] as Map<String, dynamic>)
          : const SmallWidgetSettings(),
    );
  }
}
