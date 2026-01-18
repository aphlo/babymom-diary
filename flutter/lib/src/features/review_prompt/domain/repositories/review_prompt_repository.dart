import '../entities/review_prompt_state.dart';

/// レビュー促進状態を管理するリポジトリのインターフェース
abstract class ReviewPromptRepository {
  /// 現在の状態を取得
  Future<ReviewPromptState> getState();

  /// 記録カウントを増加
  Future<ReviewPromptState> incrementRecordCount();

  /// 起動カウントを増加
  Future<ReviewPromptState> incrementLaunchCount();

  /// レビュー済みとしてマーク（満足選択時）
  Future<void> markAsReviewed();

  /// 不満選択日を記録
  Future<void> markAsDissatisfied(DateTime date);

  /// ダイアログ表示日を記録
  Future<void> recordDialogShown(DateTime date);
}
