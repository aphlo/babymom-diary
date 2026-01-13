import '../../domain/repositories/review_prompt_repository.dart';

/// ダイアログ表示日を記録するUseCase
class RecordDialogShown {
  const RecordDialogShown(this._repository);

  final ReviewPromptRepository _repository;

  /// ダイアログ表示日を記録
  Future<void> call({required DateTime date}) async {
    await _repository.recordDialogShown(date);
  }
}
