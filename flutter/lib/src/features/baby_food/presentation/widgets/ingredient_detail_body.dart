import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/types/child_icon.dart';
import '../models/ingredient_record_info.dart';
import 'ingredient_record_tile.dart';

/// 食材詳細画面のボディ
class IngredientDetailBody extends StatelessWidget {
  const IngredientDetailBody({
    super.key,
    required this.records,
    required this.childIcon,
  });

  final List<IngredientRecordInfo> records;
  final ChildIcon childIcon;

  /// 日付でグループ化された記録を返す
  Map<String, List<IngredientRecordInfo>> _groupByDate() {
    final dateFormat = DateFormat('yyyy/MM/dd');
    final grouped = <String, List<IngredientRecordInfo>>{};

    for (final record in records) {
      final dateKey = dateFormat.format(record.recordedAt);
      grouped.putIfAbsent(dateKey, () => []).add(record);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // アレルギーカード（アレルギー反応がある場合のみ）
        if (records.any((r) => r.hasAllergy)) ...[
          _AllergyWarningCard(),
          const SizedBox(height: 16),
        ],
        // 記録リスト
        if (records.isEmpty)
          _EmptyRecordsCard()
        else ...[
          _RecordListHeader(recordCount: records.length),
          // 日付ごとにグループ化して表示
          for (final entry in _groupByDate().entries) ...[
            _DateSectionHeader(date: entry.key),
            _DateSectionContent(
              records: entry.value,
              childIcon: childIcon,
            ),
            const SizedBox(height: 12),
          ],
        ],
      ],
    );
  }
}

/// アレルギー警告カード
class _AllergyWarningCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade600),
            const SizedBox(width: 8),
            Text(
              'アレルギー反応あり',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 記録がない場合のカード
class _EmptyRecordsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade200),
      ),
      child: const Center(
        child: Text(
          '記録がありません',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

/// 記録一覧ヘッダー
class _RecordListHeader extends StatelessWidget {
  const _RecordListHeader({required this.recordCount});

  final int recordCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Row(
        children: [
          const Text(
            '記録一覧',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const Spacer(),
          Text(
            '$recordCount回食べました',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

/// 日付セクションヘッダー
class _DateSectionHeader extends StatelessWidget {
  const _DateSectionHeader({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: Colors.pink.shade200),
      ),
      child: Text(
        date,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.pink.shade700,
        ),
      ),
    );
  }
}

/// 日付セクションの内容
class _DateSectionContent extends StatelessWidget {
  const _DateSectionContent({
    required this.records,
    required this.childIcon,
  });

  final List<IngredientRecordInfo> records;
  final ChildIcon childIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
          left: BorderSide(color: Colors.pink.shade200),
          right: BorderSide(color: Colors.pink.shade200),
          bottom: BorderSide(color: Colors.pink.shade200),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < records.length; i++) ...[
            IngredientRecordTile(
              record: records[i],
              childIcon: childIcon,
            ),
            if (i < records.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}
