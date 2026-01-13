import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/review_prompt_providers.dart';

/// ユーザーの満足度を確認するダイアログ
///
/// 「満足」を選択した場合はIn-App Reviewを表示、
/// 「不満」を選択した場合はフィードバック確認ダイアログを表示
class SatisfactionDialog extends ConsumerStatefulWidget {
  const SatisfactionDialog({super.key});

  /// ダイアログを表示
  ///
  /// 戻り値:
  /// - true: 満足が選択されIn-App Reviewをリクエストした
  /// - false: 不満が選択された
  /// - null: ダイアログが閉じられた（キャンセル）
  static Future<bool?> show(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (_) => const SatisfactionDialog(),
      );
    } else {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (_) => const SatisfactionDialog(),
      );
    }
  }

  @override
  ConsumerState<SatisfactionDialog> createState() => _SatisfactionDialogState();
}

class _SatisfactionDialogState extends ConsumerState<SatisfactionDialog> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildCupertinoDialog(context);
    } else {
      return _buildMaterialDialog(context);
    }
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('miluに満足いただけていますか？'),
      actions: [
        CupertinoDialogAction(
          onPressed: _isProcessing ? null : _handleSatisfied,
          child: _isProcessing
              ? const CupertinoActivityIndicator()
              : const Text('満足'),
        ),
        CupertinoDialogAction(
          onPressed: _isProcessing ? null : _handleDissatisfied,
          child: const Text('不満'),
        ),
      ],
    );
  }

  Widget _buildMaterialDialog(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'miluに満足いただけていますか？',
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      children: [
        if (_isProcessing)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          )
        else ...[
          SimpleDialogOption(
            onPressed: _handleSatisfied,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('満足', textAlign: TextAlign.center),
            ),
          ),
          SimpleDialogOption(
            onPressed: _handleDissatisfied,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('不満', textAlign: TextAlign.center),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _handleSatisfied() async {
    setState(() => _isProcessing = true);

    try {
      // In-App Reviewをリクエスト
      final inAppReviewService = ref.read(inAppReviewServiceProvider);
      await inAppReviewService.requestReview();

      // レビュー済みとしてマーク
      final markAsReviewed = ref.read(markAsReviewedUseCaseProvider);
      await markAsReviewed();

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _isProcessing = false);
      if (!mounted) return;

      // エラー時はストアページを開く
      final inAppReviewService = ref.read(inAppReviewServiceProvider);
      await inAppReviewService.openStoreListing();

      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleDissatisfied() async {
    // 現在のダイアログを閉じる
    Navigator.of(context).pop(false);

    if (!mounted) return;

    // フィードバック確認ダイアログを表示
    await FeedbackConfirmDialog.show(context);
  }
}

/// フィードバック確認ダイアログ
///
/// 不満選択後に表示され、意見送信を促す
class FeedbackConfirmDialog extends StatelessWidget {
  const FeedbackConfirmDialog({super.key});

  static const String _koeloopUrl =
      'https://koeloop.dev/embed/dddb40ea-a331-4cb9-84bb-b81187047a20?theme=light&locale=ja&primaryColor=%23E87086&showVoting=false&showFeedback=true&showFAQ=true&showEmailField=true';

  /// ダイアログを表示
  static Future<void> show(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => const FeedbackConfirmDialog(),
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => const FeedbackConfirmDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildCupertinoDialog(context);
    } else {
      return _buildMaterialDialog(context);
    }
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('よろしければ、改善のためにご意見をお聞かせください'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => _handleSendFeedback(context),
          child: const Text('意見を送る'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('今はしない'),
        ),
      ],
    );
  }

  Widget _buildMaterialDialog(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'よろしければ、改善のためにご意見をお聞かせください',
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      children: [
        SimpleDialogOption(
          onPressed: () => _handleSendFeedback(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('意見を送る', textAlign: TextAlign.center),
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.of(context).pop(),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('今はしない', textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSendFeedback(BuildContext context) async {
    // ダイアログを先に閉じる
    Navigator.of(context).pop();

    // メニューのお問い合わせと同じくアプリ内WebViewで開く
    final uri = Uri.parse(_koeloopUrl);
    await launchUrl(uri, mode: LaunchMode.inAppWebView);
  }
}
