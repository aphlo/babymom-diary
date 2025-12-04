import 'package:meta/meta.dart';

import '../../../child_record/domain/value/record_type.dart';

/// 横長ウィジェット（Medium）の設定
@immutable
class MediumWidgetSettings {
  /// 3列で表示する3種類のRecordType
  final List<RecordType> displayRecordTypes;

  /// 下部に表示する5つのクイックアクション
  final List<RecordType> quickActionTypes;

  const MediumWidgetSettings({
    this.displayRecordTypes = const [
      RecordType.breastRight,
      RecordType.formula,
      RecordType.pee,
    ],
    this.quickActionTypes = const [
      RecordType.breastRight,
      RecordType.formula,
      RecordType.pee,
      RecordType.poop,
      RecordType.temperature,
    ],
  });

  MediumWidgetSettings copyWith({
    List<RecordType>? displayRecordTypes,
    List<RecordType>? quickActionTypes,
  }) =>
      MediumWidgetSettings(
        displayRecordTypes: displayRecordTypes ?? this.displayRecordTypes,
        quickActionTypes: quickActionTypes ?? this.quickActionTypes,
      );

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
            RecordType.breastRight,
            RecordType.formula,
            RecordType.pee,
            RecordType.poop,
            RecordType.temperature,
          ],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediumWidgetSettings &&
          runtimeType == other.runtimeType &&
          _listEquals(displayRecordTypes, other.displayRecordTypes) &&
          _listEquals(quickActionTypes, other.quickActionTypes);

  @override
  int get hashCode => Object.hash(
        Object.hashAll(displayRecordTypes),
        Object.hashAll(quickActionTypes),
      );

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// 正方形ウィジェット（Small）の設定
@immutable
class SmallWidgetSettings {
  /// 表示するRecordType（nullで全種類）
  final RecordType? filterRecordType;

  const SmallWidgetSettings({
    this.filterRecordType,
  });

  SmallWidgetSettings copyWith({
    RecordType? filterRecordType,
    bool clearFilter = false,
  }) =>
      SmallWidgetSettings(
        filterRecordType:
            clearFilter ? null : (filterRecordType ?? this.filterRecordType),
      );

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmallWidgetSettings &&
          runtimeType == other.runtimeType &&
          filterRecordType == other.filterRecordType;

  @override
  int get hashCode => filterRecordType.hashCode;
}

/// ウィジェット設定全体
@immutable
class WidgetSettings {
  final MediumWidgetSettings mediumWidget;
  final SmallWidgetSettings smallWidget;

  const WidgetSettings({
    this.mediumWidget = const MediumWidgetSettings(),
    this.smallWidget = const SmallWidgetSettings(),
  });

  WidgetSettings copyWith({
    MediumWidgetSettings? mediumWidget,
    SmallWidgetSettings? smallWidget,
  }) =>
      WidgetSettings(
        mediumWidget: mediumWidget ?? this.mediumWidget,
        smallWidget: smallWidget ?? this.smallWidget,
      );

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetSettings &&
          runtimeType == other.runtimeType &&
          mediumWidget == other.mediumWidget &&
          smallWidget == other.smallWidget;

  @override
  int get hashCode => Object.hash(mediumWidget, smallWidget);
}
