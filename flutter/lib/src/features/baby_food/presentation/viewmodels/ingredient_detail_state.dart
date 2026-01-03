import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_detail_state.freezed.dart';

/// 食材詳細画面のUI状態
@freezed
sealed class IngredientDetailState with _$IngredientDetailState {
  const IngredientDetailState._();

  const factory IngredientDetailState({
    /// 現在の食材名（カスタム食材の名前変更に対応）
    required String currentIngredientName,

    /// カスタム食材かどうか
    required bool isCustomIngredient,

    /// 処理中フラグ
    @Default(false) bool isProcessing,

    /// 保留中のUIイベント
    IngredientDetailUiEvent? pendingUiEvent,
  }) = _IngredientDetailState;

  /// 初期状態を作成
  factory IngredientDetailState.initial({
    required String ingredientName,
    required bool isCustomIngredient,
  }) {
    return IngredientDetailState(
      currentIngredientName: ingredientName,
      isCustomIngredient: isCustomIngredient,
    );
  }
}

/// UI側で処理すべきイベント
@freezed
sealed class IngredientDetailUiEvent with _$IngredientDetailUiEvent {
  /// スナックバーでメッセージを表示
  const factory IngredientDetailUiEvent.showMessage(String message) =
      _ShowMessage;

  /// 画面を閉じる（削除後）
  const factory IngredientDetailUiEvent.navigateBack() = _NavigateBack;
}
