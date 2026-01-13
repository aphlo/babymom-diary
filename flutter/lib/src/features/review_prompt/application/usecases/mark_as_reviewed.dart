import '../../domain/repositories/review_prompt_repository.dart';

/// レビュー済みとしてマークするUseCase
class MarkAsReviewed {
  const MarkAsReviewed(this._repository);

  final ReviewPromptRepository _repository;

  /// レビュー済みとしてマーク
  Future<void> call() async {
    await _repository.markAsReviewed();
  }
}
