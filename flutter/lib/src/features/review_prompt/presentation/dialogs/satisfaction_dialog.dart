import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/review_prompt_providers.dart';

/// ユーザーの満足度を確認するダイアログ
///
/// 「満足」を選択した場合はIn-App Reviewを表示、
/// 「不満」を選択した場合はお問い合わせページに遷移
class SatisfactionDialog extends ConsumerStatefulWidget {
  const SatisfactionDialog({super.key});

  /// ダイアログを表示
  ///
  /// 戻り値:
  /// - true: 満足が選択されIn-App Reviewをリクエストした
  /// - false: 不満が選択されお問い合わせページに遷移した
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
  static const String _inquiryUrl =
      'https://babymom-diary.web.app/inquiry.html';

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
    return AlertDialog(
      title: const Text('miluに満足いただけていますか？'),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : _handleSatisfied,
          child: _isProcessing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('満足'),
        ),
        TextButton(
          onPressed: _isProcessing ? null : _handleDissatisfied,
          child: const Text('不満'),
        ),
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
    // お問い合わせページを開く
    final uri = Uri.parse(_inquiryUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!mounted) return;
    Navigator.of(context).pop(false);
  }
}
