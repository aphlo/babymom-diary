import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_other_tags_state.freezed.dart';

/// ManageOtherTagsViewModel の状態
@freezed
sealed class ManageOtherTagsState with _$ManageOtherTagsState {
  const factory ManageOtherTagsState({
    @Default('') String input,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = _ManageOtherTagsState;
}
