import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/types/child_icon.dart';
import '../models/ingredient_record_info.dart';
import 'ingredient_record_tile.dart';

/// 食材詳細画面のボディ
class IngredientDetailBody extends StatelessWidget {
  const IngredientDetailBody({
    super.key,
    required this.records,
    required this.childIcon,
    this.onRecordTap,
  });

  final List<IngredientRecordInfo> records;
  final ChildIcon childIcon;
  final void Function(IngredientRecordInfo record)? onRecordTap;

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
              onRecordTap: onRecordTap,
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

/// 記録がない場合の表示
class _EmptyRecordsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text(
          '記録がありません',
          style: TextStyle(color: context.subtextColor),
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
          Text(
            '記録一覧',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.subtextColor,
            ),
          ),
          const Spacer(),
          Text(
            '$recordCount回食べました',
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondary,
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
        color: context.dateSectionHeaderBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: context.dateSectionBorder),
      ),
      child: Text(
        date,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: context.dateSectionText,
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
    this.onRecordTap,
  });

  final List<IngredientRecordInfo> records;
  final ChildIcon childIcon;
  final void Function(IngredientRecordInfo record)? onRecordTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = context.dateSectionBorder;
    return Container(
      decoration: BoxDecoration(
        color: context.menuSectionBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
          left: BorderSide(color: borderColor),
          right: BorderSide(color: borderColor),
          bottom: BorderSide(color: borderColor),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < records.length; i++) ...[
            IngredientRecordTile(
              record: records[i],
              childIcon: childIcon,
              onTap:
                  onRecordTap != null ? () => onRecordTap!(records[i]) : null,
            ),
            if (i < records.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}
