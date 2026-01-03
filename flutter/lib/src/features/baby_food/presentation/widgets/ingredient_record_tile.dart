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
    this.onTap,
  });

  final IngredientRecordInfo record;
  final ChildIcon childIcon;
  final VoidCallback? onTap;

  static final _timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 左側: 時刻、量、メモ
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 時刻
                    Text(
                      _timeFormat.format(record.recordedAt),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // 量
                    if (record.amount != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        '量: ${record.amount}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                    // アレルギー
                    if (record.hasAllergy) ...[
                      const SizedBox(height: 8),
                      Text(
                        'アレルギー反応あり',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                    // メモ
                    if (record.memo != null && record.memo!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'メモ: ${record.memo}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // 右側: 反応
              if (record.reaction != null)
                ReactionDisplay(
                  reaction: record.reaction!,
                  childIcon: childIcon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
