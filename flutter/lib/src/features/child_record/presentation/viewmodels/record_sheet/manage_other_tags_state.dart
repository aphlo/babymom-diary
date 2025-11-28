import 'package:flutter/foundation.dart';

/// ManageOtherTagsViewModel の状態
@immutable
class ManageOtherTagsState {
  const ManageOtherTagsState({
    this.input = '',
    this.isSubmitting = false,
    this.errorMessage,
  });

  static const Object _sentinel = Object();

  final String input;
  final bool isSubmitting;
  final String? errorMessage;

  ManageOtherTagsState copyWith({
    String? input,
    bool? isSubmitting,
    Object? errorMessage = _sentinel,
  }) {
    return ManageOtherTagsState(
      input: input ?? this.input,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
