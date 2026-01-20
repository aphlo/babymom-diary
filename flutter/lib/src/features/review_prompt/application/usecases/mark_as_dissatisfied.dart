import '../../domain/repositories/review_prompt_repository.dart';

/// 不満としてマークするUseCase
class MarkAsDissatisfied {
  const MarkAsDissatisfied(this._repository);

  final ReviewPromptRepository _repository;

  /// 不満選択日を記録
  Future<void> call({required DateTime date}) async {
    await _repository.markAsDissatisfied(date);
  }
}
