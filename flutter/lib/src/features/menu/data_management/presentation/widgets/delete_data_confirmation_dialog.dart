import 'package:flutter/material.dart';

/// Dialog to confirm deletion of all household data.
///
/// Shows a warning message and requires explicit confirmation from the user.
class DeleteDataConfirmationDialog extends StatelessWidget {
  const DeleteDataConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 8),
          Text('データ削除の確認'),
        ],
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '以下のデータがすべて削除されます：',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text('• 子どもの情報（名前・誕生日など）'),
          Text('• ワクチン接種記録・予約'),
          Text('• 子どもの日々の記録（授乳・おむつなど）'),
          Text('• 成長記録（身長・体重）'),
          Text('• カレンダーイベント'),
          Text('• ママの記録・日記'),
          Text('• その他すべてのデータ'),
          SizedBox(height: 16),
          Text(
            '⚠️ この操作は取り消せません',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '※ 世帯共有のメンバー情報は削除されません',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('削除する'),
        ),
      ],
    );
  }

  /// Shows the dialog and returns true if the user confirms deletion.
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteDataConfirmationDialog(),
    );
    return result ?? false;
  }
}
