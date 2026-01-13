import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/review_prompt_providers.dart';
import '../dialogs/satisfaction_dialog.dart';

/// レビュー促進ダイアログの表示を制御するコントローラ
class ReviewPromptController {
  const ReviewPromptController(this._ref);

  final Ref _ref;

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
    final incrementRecordCount = _ref.read(incrementRecordCountUseCaseProvider);
    final shouldShow = await incrementRecordCount(now: now);

    if (!shouldShow) return;

    // ダイアログ表示日を記録
    final recordDialogShown = _ref.read(recordDialogShownUseCaseProvider);
    await recordDialogShown(date: now);

    // contextが有効か確認
    if (!context.mounted) return;

    // ダイアログを表示
    await SatisfactionDialog.show(context);
  }
}
