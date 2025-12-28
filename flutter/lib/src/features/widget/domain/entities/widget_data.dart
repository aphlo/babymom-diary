import 'package:freezed_annotation/freezed_annotation.dart';

import 'widget_child.dart';
import 'widget_record.dart';

part 'widget_data.freezed.dart';

/// ウィジェットと共有するデータ
@Freezed(toJson: false, fromJson: false)
sealed class WidgetData with _$WidgetData {
  const WidgetData._();

  const factory WidgetData({
    required DateTime lastUpdated,
    String? selectedChildId,
    @Default([]) List<WidgetChild> children,
    @Default({}) Map<String, List<WidgetRecord>> recentRecords,
  }) = _WidgetData;

  factory WidgetData.empty() => WidgetData(
        lastUpdated: DateTime.now(),
      );

  /// 選択中の子供の直近の記録を取得
  List<WidgetRecord> get selectedChildRecords {
    if (selectedChildId == null) return [];
    return recentRecords[selectedChildId] ?? [];
  }

  /// 選択中の子供情報を取得
  WidgetChild? get selectedChild {
    if (selectedChildId == null) return null;
    try {
      return children.firstWhere((c) => c.id == selectedChildId);
    } catch (_) {
      return children.isNotEmpty ? children.first : null;
    }
  }

  Map<String, dynamic> toJson() => {
        'lastUpdated': lastUpdated.toUtc().toIso8601String(),
        if (selectedChildId != null) 'selectedChildId': selectedChildId,
        'children': children.map((c) => c.toJson()).toList(),
        'recentRecords': recentRecords.map(
          (childId, records) => MapEntry(
            childId,
            records.map((r) => r.toJson()).toList(),
          ),
        ),
      };

  factory WidgetData.fromJson(Map<String, dynamic> json) {
    final recentRecordsJson =
        json['recentRecords'] as Map<String, dynamic>? ?? {};

    return WidgetData(
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      selectedChildId: json['selectedChildId'] as String?,
      children: (json['children'] as List<dynamic>?)
              ?.map((c) => WidgetChild.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      recentRecords: recentRecordsJson.map(
        (childId, recordsList) => MapEntry(
          childId,
          (recordsList as List<dynamic>)
              .map((r) => WidgetRecord.fromJson(r as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }
}
