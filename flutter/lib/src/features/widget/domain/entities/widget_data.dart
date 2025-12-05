import 'package:meta/meta.dart';

import 'widget_child.dart';
import 'widget_record.dart';

/// ウィジェットと共有するデータ
@immutable
class WidgetData {
  final DateTime lastUpdated;
  final String? selectedChildId;
  final List<WidgetChild> children;
  final Map<String, List<WidgetRecord>> recentRecords;

  const WidgetData({
    required this.lastUpdated,
    this.selectedChildId,
    this.children = const [],
    this.recentRecords = const {},
  });

  factory WidgetData.empty() => WidgetData(
        lastUpdated: DateTime.now(),
      );

  WidgetData copyWith({
    DateTime? lastUpdated,
    String? selectedChildId,
    List<WidgetChild>? children,
    Map<String, List<WidgetRecord>>? recentRecords,
  }) =>
      WidgetData(
        lastUpdated: lastUpdated ?? this.lastUpdated,
        selectedChildId: selectedChildId ?? this.selectedChildId,
        children: children ?? this.children,
        recentRecords: recentRecords ?? this.recentRecords,
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
        'lastUpdated': lastUpdated.toIso8601String(),
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetData &&
          runtimeType == other.runtimeType &&
          lastUpdated == other.lastUpdated &&
          selectedChildId == other.selectedChildId &&
          _listEquals(children, other.children) &&
          _mapEquals(recentRecords, other.recentRecords);

  @override
  int get hashCode =>
      Object.hash(lastUpdated, selectedChildId, children, recentRecords);

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  bool _mapEquals<K, V>(Map<K, List<V>> a, Map<K, List<V>> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!_listEquals(a[key]!, b[key]!)) return false;
    }
    return true;
  }
}
