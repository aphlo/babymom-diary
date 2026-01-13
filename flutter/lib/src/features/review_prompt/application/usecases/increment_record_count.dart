import '../../domain/repositories/review_prompt_repository.dart';

/// 記録カウントを増加するUseCase
///
/// 記録操作後に呼び出し、ダイアログを表示すべきかどうかを返す
class IncrementRecordCount {
  const IncrementRecordCount(this._repository);

  final ReviewPromptRepository _repository;

  /// 記録カウントを増加し、ダイアログを表示すべきかどうかを返す
  Future<bool> call({required DateTime now}) async {
    // 増加前の状態を取得
    final stateBefore = await _repository.getState();

    // ダイアログを表示すべきか判定（増加前の状態で判定）
    final shouldShow = stateBefore.shouldShowAfterRecordIncrement(now: now);

    // カウントを増加
    await _repository.incrementRecordCount();

    return shouldShow;
  }
}
