import 'package:flutter/material.dart';

/// Dialog to confirm deletion of all household data.
///
/// Shows a warning message and requires explicit confirmation from the user.
class DeleteDataConfirmationDialog extends StatefulWidget {
  const DeleteDataConfirmationDialog({super.key});

  @override
  State<DeleteDataConfirmationDialog> createState() =>
      _DeleteDataConfirmationDialogState();

  /// Shows the dialog and returns true if the user confirms deletion.
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteDataConfirmationDialog(),
    );
    return result ?? false;
  }
}

class _DeleteDataConfirmationDialogState
    extends State<DeleteDataConfirmationDialog> {
  static const _requiredTapCount = 3;
  int _tapCount = 0;

  void _handleDeleteTap(bool isActivated) {
    if (isActivated) return;
    if (_tapCount < _requiredTapCount) {
      setState(() {
        _tapCount += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final remainingTaps =
        (_requiredTapCount - _tapCount).clamp(0, _requiredTapCount);
    final isActivated = remainingTaps == 0;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 8),
          Text('データ削除の確認'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '以下のデータがすべて削除されます：',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text('• 子どもの情報（名前・誕生日など）'),
          const Text('• ワクチン接種記録・予約'),
          const Text('• 子どもの日々の記録（授乳・おむつなど）'),
          const Text('• 成長記録（身長・体重）'),
          const Text('• カレンダーイベント'),
          const Text('• ママの記録・日記'),
          const Text('• その他すべてのデータ'),
          const SizedBox(height: 16),
          const Text(
            '⚠️ この操作は取り消せません',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '※ 世帯共有のメンバー情報は削除されません',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '削除ボタンは3回タップしないと有効になりません。',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            isActivated
                ? '削除ボタンが有効になりました。最後にもう一度タップして削除してください。'
                : 'あと$remainingTaps回タップで削除ボタンが有効になります。',
            style: TextStyle(color: isActivated ? Colors.red : Colors.orange),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        GestureDetector(
          onTap: () => _handleDeleteTap(isActivated),
          child: FilledButton(
            onPressed:
                isActivated ? () => Navigator.of(context).pop(true) : null,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('削除する'),
          ),
        ),
      ],
    );
  }
}
