import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/types/child_icon.dart';
import '../models/ingredient_record_info.dart';
import 'reaction_display.dart';

/// 食材記録のタイル
class IngredientRecordTile extends StatelessWidget {
  const IngredientRecordTile({
    super.key,
    required this.record,
    required this.childIcon,
  });

  final IngredientRecordInfo record;
  final ChildIcon childIcon;

  static final _timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 時刻と反応
          Row(
            children: [
              Text(
                _timeFormat.format(record.recordedAt),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (record.reaction != null)
                ReactionDisplay(
                  reaction: record.reaction!,
                  childIcon: childIcon,
                ),
            ],
          ),
          // 量
          if (record.amount != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.restaurant, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '量: ${record.amount}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
          // アレルギー
          if (record.hasAllergy) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.warning_amber, size: 16, color: Colors.red.shade600),
                const SizedBox(width: 4),
                Text(
                  'アレルギー反応あり',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ],
          // メモ
          if (record.memo != null && record.memo!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.note, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'メモ: ${record.memo}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
