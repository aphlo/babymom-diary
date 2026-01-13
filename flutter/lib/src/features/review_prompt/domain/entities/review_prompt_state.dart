import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_prompt_state.freezed.dart';
part 'review_prompt_state.g.dart';

/// レビュー促進の状態を表すエンティティ
@freezed
sealed class ReviewPromptState with _$ReviewPromptState {
  const ReviewPromptState._();

  const factory ReviewPromptState({
    /// 記録操作の累計回数
    required int recordCount,

    /// アプリ起動回数
    required int appLaunchCount,

    /// レビュー済みフラグ
    required bool hasReviewed,

    /// 最後にダイアログを表示した日付（ISO8601形式）
    String? lastShownDate,
  }) = _ReviewPromptState;

  factory ReviewPromptState.initial() => const ReviewPromptState(
        recordCount: 0,
        appLaunchCount: 0,
        hasReviewed: false,
        lastShownDate: null,
      );

  factory ReviewPromptState.fromJson(Map<String, dynamic> json) =>
      _$ReviewPromptStateFromJson(json);

  /// ダイアログを表示すべきかどうかを判定
  bool shouldShowDialog({required DateTime now}) {
    // レビュー済みなら表示しない
    if (hasReviewed) return false;

    // 本日すでに表示済みなら表示しない
    if (lastShownDate != null) {
      final lastDate = DateTime.tryParse(lastShownDate!);
      if (lastDate != null && _isSameDay(lastDate, now)) {
        return false;
      }
    }

    // 条件A: 記録回数がちょうど3回目に達した
    final conditionA = recordCount == 3;

    // 条件B: 起動3回以上 かつ 記録1回以上
    final conditionB = appLaunchCount >= 3 && recordCount >= 1;

    return conditionA || conditionB;
  }

  /// 記録カウント増加後にダイアログを表示すべきかを判定
  /// （増加前の状態で呼び出す）
  bool shouldShowAfterRecordIncrement({required DateTime now}) {
    // レビュー済みなら表示しない
    if (hasReviewed) return false;

    // 本日すでに表示済みなら表示しない
    if (lastShownDate != null) {
      final lastDate = DateTime.tryParse(lastShownDate!);
      if (lastDate != null && _isSameDay(lastDate, now)) {
        return false;
      }
    }

    // 増加後の記録回数
    final nextRecordCount = recordCount + 1;

    // 条件A: 記録回数がちょうど3回目に達する
    final conditionA = nextRecordCount == 3;

    // 条件B: 起動3回以上 かつ 記録1回以上（増加後なので常に1回以上）
    final conditionB = appLaunchCount >= 3 && nextRecordCount >= 1;

    return conditionA || conditionB;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
