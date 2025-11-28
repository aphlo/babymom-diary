import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/record_tag_controller.dart';
import 'manage_other_tags_state.dart';

export 'manage_other_tags_state.dart';

part 'manage_other_tags_view_model.g.dart';

/// タグ管理画面の ViewModel
///
/// 使用例:
/// ```dart
/// final state = ref.watch(manageOtherTagsViewModelProvider(householdId));
/// final notifier = ref.read(manageOtherTagsViewModelProvider(householdId).notifier);
/// ```
@riverpod
class ManageOtherTagsViewModel extends _$ManageOtherTagsViewModel {
  @override
  ManageOtherTagsState build(String householdId) {
    return const ManageOtherTagsState();
  }

  List<String> get _currentTags =>
      ref.read(recordTagControllerProvider(householdId)).value ??
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
      await ref
          .read(recordTagControllerProvider(householdId).notifier)
          .add(candidate);
      state = state.copyWith(input: '', isSubmitting: false);
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
    }
  }

  Future<void> removeTag(String tag) async {
    if (state.isSubmitting) {
      return;
    }
    state = state.copyWith(isSubmitting: true);
    try {
      await ref
          .read(recordTagControllerProvider(householdId).notifier)
          .remove(tag);
      state = state.copyWith(isSubmitting: false);
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
    }
  }
}
