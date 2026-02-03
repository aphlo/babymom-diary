import 'package:freezed_annotation/freezed_annotation.dart';

part 'vaccine_visibility_settings_state.freezed.dart';

/// ワクチン表示設定画面の状態
@freezed
sealed class VaccineVisibilitySettingsState
    with _$VaccineVisibilitySettingsState {
  const VaccineVisibilitySettingsState._();

  const factory VaccineVisibilitySettingsState({
    /// ローディング中かどうか
    @Default(false) bool isLoading,

    /// エラーメッセージ
    String? error,

    /// ワクチンIDをキーとした表示設定マップ
    @Default({}) Map<String, bool> visibilitySettings,

    /// 全てのワクチン情報（id, name）
    @Default([]) List<VaccineDisplayInfo> vaccines,
  }) = _VaccineVisibilitySettingsState;

  /// エラーをクリアした新しい状態を返す
  VaccineVisibilitySettingsState clearError() => copyWith(error: null);
}

/// ワクチンの表示情報
@freezed
sealed class VaccineDisplayInfo with _$VaccineDisplayInfo {
  const factory VaccineDisplayInfo({
    required String id,
    required String name,
  }) = _VaccineDisplayInfo;
}
