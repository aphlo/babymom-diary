import 'package:meta/meta.dart';

/// ワクチン表示設定画面の状態
@immutable
class VaccineVisibilitySettingsState {
  const VaccineVisibilitySettingsState({
    this.isLoading = false,
    this.error,
    this.visibilitySettings = const {},
    this.vaccines = const [],
    this.isSaving = false,
  });

  /// ローディング中かどうか
  final bool isLoading;

  /// エラーメッセージ
  final String? error;

  /// ワクチンIDをキーとした表示設定マップ
  final Map<String, bool> visibilitySettings;

  /// 全てのワクチン情報（id, name）
  final List<VaccineDisplayInfo> vaccines;

  /// 保存中かどうか
  final bool isSaving;

  VaccineVisibilitySettingsState copyWith({
    bool? isLoading,
    String? error,
    Map<String, bool>? visibilitySettings,
    List<VaccineDisplayInfo>? vaccines,
    bool? isSaving,
    bool clearError = false,
  }) {
    return VaccineVisibilitySettingsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      visibilitySettings: visibilitySettings ?? this.visibilitySettings,
      vaccines: vaccines ?? this.vaccines,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

/// ワクチンの表示情報
@immutable
class VaccineDisplayInfo {
  const VaccineDisplayInfo({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}
