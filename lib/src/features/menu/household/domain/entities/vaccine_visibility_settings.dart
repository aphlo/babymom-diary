import 'package:meta/meta.dart';

/// ワクチンの表示・非表示設定
///
/// 世帯単位で管理され、特定のワクチンを画面上で表示するかどうかを制御します。
@immutable
class VaccineVisibilitySettings {
  const VaccineVisibilitySettings({
    required this.householdId,
    required this.visibilityMap,
  });

  /// 世帯ID
  final String householdId;

  /// ワクチンIDをキーとした表示設定マップ
  /// true: 表示, false: 非表示
  /// キーが存在しない場合はデフォルトで表示
  final Map<String, bool> visibilityMap;

  /// 指定されたワクチンIDが表示されるべきかどうか
  bool isVisible(String vaccineId) {
    return visibilityMap[vaccineId] ?? true; // デフォルトは表示
  }

  /// ワクチンの可視性を更新した新しいインスタンスを返す
  VaccineVisibilitySettings setVisibility(String vaccineId, bool isVisible) {
    final updatedMap = Map<String, bool>.from(visibilityMap);
    updatedMap[vaccineId] = isVisible;
    return VaccineVisibilitySettings(
      householdId: householdId,
      visibilityMap: updatedMap,
    );
  }

  /// 表示されるべきワクチンIDのリストを返す
  List<String> get visibleVaccineIds {
    return visibilityMap.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  /// 非表示に設定されたワクチンIDのリストを返す
  List<String> get hiddenVaccineIds {
    return visibilityMap.entries
        .where((entry) => !entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  VaccineVisibilitySettings copyWith({
    String? householdId,
    Map<String, bool>? visibilityMap,
  }) {
    return VaccineVisibilitySettings(
      householdId: householdId ?? this.householdId,
      visibilityMap: visibilityMap ?? this.visibilityMap,
    );
  }
}
