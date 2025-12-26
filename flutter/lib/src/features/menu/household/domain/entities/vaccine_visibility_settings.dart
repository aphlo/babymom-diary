import 'package:freezed_annotation/freezed_annotation.dart';

part 'vaccine_visibility_settings.freezed.dart';

/// ワクチンの表示・非表示設定
///
/// 世帯単位で管理され、特定のワクチンを画面上で表示するかどうかを制御します。
@freezed
sealed class VaccineVisibilitySettings with _$VaccineVisibilitySettings {
  const VaccineVisibilitySettings._();

  const factory VaccineVisibilitySettings({
    /// 世帯ID
    required String householdId,

    /// ワクチンIDをキーとした表示設定マップ
    /// true: 表示, false: 非表示
    /// キーが存在しない場合はデフォルトで表示
    required Map<String, bool> visibilityMap,
  }) = _VaccineVisibilitySettings;

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
}
