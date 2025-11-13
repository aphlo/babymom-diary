import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../record_view_model.dart';

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

final manageOtherTagsViewModelProvider = AutoDisposeStateNotifierProvider<
    ManageOtherTagsViewModel, ManageOtherTagsState>((ref) {
  return ManageOtherTagsViewModel(ref);
});

class ManageOtherTagsViewModel extends StateNotifier<ManageOtherTagsState> {
  ManageOtherTagsViewModel(this._ref) : super(const ManageOtherTagsState());

  final Ref _ref;

  List<String> get _currentTags =>
      _ref.read(recordViewModelProvider).otherTagsAsync.valueOrNull ??
      const <String>[];

  void updateInput(String value) {
    if (state.input == value) {
      return;
    }
    state = state.copyWith(
      input: value,
      errorMessage: null,
    );
  }

  Future<void> addTag() async {
    if (state.isSubmitting) {
      return;
    }
    final candidate = state.input.trim();
    if (candidate.isEmpty) {
      state = state.copyWith(errorMessage: '文字を入力してください');
      return;
    }
    if (_currentTags.contains(candidate)) {
      state = state.copyWith(errorMessage: '既に登録されています');
      return;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await _ref.read(recordViewModelProvider.notifier).addTag(candidate);
      if (!mounted) return;
      state = state.copyWith(input: '');
    } finally {
      if (mounted) {
        state = state.copyWith(isSubmitting: false);
      }
    }
  }

  Future<void> removeTag(String tag) async {
    if (state.isSubmitting) {
      return;
    }
    state = state.copyWith(isSubmitting: true);
    try {
      await _ref.read(recordViewModelProvider.notifier).removeTag(tag);
    } finally {
      if (mounted) {
        state = state.copyWith(isSubmitting: false);
      }
    }
  }
}
