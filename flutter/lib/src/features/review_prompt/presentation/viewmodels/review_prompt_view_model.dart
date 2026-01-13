import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/review_prompt_providers.dart';
import '../dialogs/satisfaction_dialog.dart';

part 'review_prompt_view_model.g.dart';

/// レビュープロンプトのグローバル状態
class ReviewPromptViewState {
  const ReviewPromptViewState({
    this.shouldShowDialog = false,
  });

  /// ダイアログを表示すべきかどうか
  final bool shouldShowDialog;

  ReviewPromptViewState copyWith({
    bool? shouldShowDialog,
  }) {
    return ReviewPromptViewState(
      shouldShowDialog: shouldShowDialog ?? this.shouldShowDialog,
    );
  }
}

/// レビュープロンプトのグローバルViewModel
///
/// 各featureの記録操作後に呼び出し、条件を満たす場合はダイアログ表示フラグをONにする。
/// UIレイヤー（App等）でこの状態を監視し、ダイアログを表示する。
@Riverpod(keepAlive: true)
class ReviewPromptViewModel extends _$ReviewPromptViewModel {
  @override
  ReviewPromptViewState build() {
    return const ReviewPromptViewState();
  }

  /// 記録操作後に呼び出し、条件を満たす場合はダイアログを表示
  ///
  /// [context] ダイアログを表示するためのBuildContext
  ///
  /// この関数は以下の処理を行う:
  /// 1. 記録カウントを増加
  /// 2. 条件を満たす場合はダイアログを表示
  /// 3. ダイアログ表示日を記録
  Future<void> onRecordAdded(BuildContext context) async {
    final now = DateTime.now();

    // 記録カウントを増加し、ダイアログを表示すべきか判定
    final incrementRecordCount = ref.read(incrementRecordCountUseCaseProvider);
    final shouldShow = await incrementRecordCount(now: now);

    if (!shouldShow) return;

    // ダイアログ表示日を記録
    final recordDialogShown = ref.read(recordDialogShownUseCaseProvider);
    await recordDialogShown(date: now);

    // contextが有効か確認
    if (!context.mounted) return;

    // ダイアログを表示
    await SatisfactionDialog.show(context);
  }

  /// 記録カウントのみを増加（ダイアログは表示しない）
  ///
  /// ViewModelからBuildContextなしで呼び出す場合に使用。
  /// 条件を満たす場合はshouldShowDialogフラグがONになる。
  Future<bool> incrementRecordCountOnly() async {
    final now = DateTime.now();

    // 記録カウントを増加し、ダイアログを表示すべきか判定
    final incrementRecordCount = ref.read(incrementRecordCountUseCaseProvider);
    final shouldShow = await incrementRecordCount(now: now);

    if (shouldShow) {
      // ダイアログ表示日を記録
      final recordDialogShown = ref.read(recordDialogShownUseCaseProvider);
      await recordDialogShown(date: now);

      // フラグをON
      state = state.copyWith(shouldShowDialog: true);
    }

    return shouldShow;
  }

  /// ダイアログを表示（UIレイヤーから呼び出す）
  Future<void> showDialogIfNeeded(BuildContext context) async {
    if (!state.shouldShowDialog) return;

    // フラグをリセット
    state = state.copyWith(shouldShowDialog: false);

    // contextが有効か確認
    if (!context.mounted) return;

    // ダイアログを表示
    await SatisfactionDialog.show(context);
  }

  /// ダイアログ表示フラグをリセット
  void clearDialogFlag() {
    state = state.copyWith(shouldShowDialog: false);
  }
}
