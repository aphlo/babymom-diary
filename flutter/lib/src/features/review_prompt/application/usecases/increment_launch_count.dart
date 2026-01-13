import '../../domain/repositories/review_prompt_repository.dart';

/// アプリ起動カウントを増加するUseCase
class IncrementLaunchCount {
  const IncrementLaunchCount(this._repository);

  final ReviewPromptRepository _repository;

  /// 起動カウントを増加
  Future<void> call() async {
    await _repository.incrementLaunchCount();
  }
}
