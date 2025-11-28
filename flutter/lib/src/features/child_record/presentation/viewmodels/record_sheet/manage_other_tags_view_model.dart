import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../providers/record_tag_controller.dart';

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

/// タグ管理画面の ViewModel
///
/// 使用例:
/// ```dart
/// final viewModel = ref.watch(manageOtherTagsViewModelProvider(householdId));
/// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
/// ```
final manageOtherTagsViewModelProvider = StateNotifierProvider.autoDispose
    .family<ManageOtherTagsViewModel, ManageOtherTagsState, String>(
        (ref, householdId) {
  return ManageOtherTagsViewModel(ref, householdId);
});

class ManageOtherTagsViewModel extends StateNotifier<ManageOtherTagsState> {
  ManageOtherTagsViewModel(this._ref, this._householdId)
      : super(const ManageOtherTagsState());

  final Ref _ref;
  final String _householdId;

  List<String> get _currentTags =>
      _ref.read(recordTagControllerProvider(_householdId)).value ??
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
      await _ref
          .read(recordTagControllerProvider(_householdId).notifier)
          .add(candidate);
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
      await _ref
          .read(recordTagControllerProvider(_householdId).notifier)
          .remove(tag);
    } finally {
      if (mounted) {
        state = state.copyWith(isSubmitting: false);
      }
    }
  }
}
