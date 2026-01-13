import '../../domain/repositories/review_prompt_repository.dart';

/// レビュー促進ダイアログの表示可否を判定するUseCase
class CheckReviewPrompt {
  const CheckReviewPrompt(this._repository);

  final ReviewPromptRepository _repository;

  /// ダイアログを表示すべきかどうかを判定
  Future<bool> call({required DateTime now}) async {
    final state = await _repository.getState();
    return state.shouldShowDialog(now: now);
  }
}
