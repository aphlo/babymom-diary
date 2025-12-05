import 'package:flutter/material.dart';

import '../../child_record.dart';
import '../models/record_item_model.dart';
import 'other_tags_preview.dart';

typedef RecordSlotTapCallback = void Function(
  int hour,
  RecordType type,
);

class RecordTableCell extends StatelessWidget {
  const RecordTableCell({
    super.key,
    required this.records,
    required this.hour,
    required this.types,
    required this.onTap,
    required this.rowHeight,
  });

  final List<RecordItemModel> records;
  final int hour;
  final List<RecordType> types;
  final RecordSlotTapCallback onTap;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final filtered = records
        .where((e) => e.at.hour == hour && types.contains(e.type))
        .toList();

    // 代表的なタイプを取得（バッジの色などを決定するため）
    // 複数ある場合はリストの最初のものを使用
    final primaryType = types.first;

    if (primaryType == RecordType.other) {
      final tags = filtered
          .expand((record) => record.tags)
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList(growable: false);
      final fallbackText = filtered.isEmpty ? '' : '${filtered.length}';

      return InkWell(
        onTap: () => onTap(hour, primaryType),
        child: SizedBox(
          height: rowHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: tags.isEmpty
                ? (fallbackText.isEmpty
                    ? const SizedBox.shrink()
                    : Center(
                        child: _buildCountBadge(
                          context,
                          primaryType,
                          fallbackText,
                        ),
                      ))
                : OtherTagsPreview(tags: tags),
          ),
        ),
      );
    }

    var text = '';
    if (filtered.isNotEmpty) {
      switch (primaryType) {
        case RecordType.formula:
        case RecordType.pump:
          final sum = filtered.fold<double>(0, (p, e) => p + (e.amount ?? 0));
          text = sum == 0 ? '${filtered.length}' : sum.toStringAsFixed(0);
          break;
        case RecordType.temperature:
          if (filtered.length > 1) {
            final latest = filtered.last.amount;
            text = latest != null
                ? '${latest.toStringAsFixed(1)}..'
                : '${filtered.length}';
          } else {
            final latest = filtered.isNotEmpty ? filtered.last.amount : null;
            text = latest != null ? latest.toStringAsFixed(1) : '';
          }
          break;
        case RecordType.breastLeft:
        case RecordType.breastRight:
          // 授乳（左右）の場合は合計回数を表示
          text = '${filtered.length}';
          break;
        case RecordType.pee:
        case RecordType.poop:
        case RecordType.other:
          text = '${filtered.length}';
          break;
      }
    }

    return InkWell(
      onTap: () => onTap(hour, primaryType),
      child: SizedBox(
        height: rowHeight,
        child: Center(
          child: _buildCountBadge(context, primaryType, text),
        ),
      ),
    );
  }
}

Widget _buildCountBadge(
  BuildContext context,
  RecordType type,
  String text,
) {
  if (text.isEmpty) {
    return const SizedBox.shrink();
  }

  final scheme = Theme.of(context).colorScheme;
  final colors = _badgeColorsForRecordType(type, scheme);

  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.center,
    child: _CountBadge(
      label: text,
      background: colors.background,
      foreground: colors.foreground,
    ),
  );
}

_BadgeColors _badgeColorsForRecordType(RecordType type, ColorScheme scheme) {
  switch (type) {
    case RecordType.breastLeft:
      return const _BadgeColors(
        background: Color(0xFFffa600),
        foreground: Colors.white,
      );
    case RecordType.breastRight:
      return const _BadgeColors(
        background: Color(0xFFffa600),
        foreground: Colors.white,
      );
    case RecordType.formula:
      return const _BadgeColors(
        background: Color(0xFF00c3ff),
        foreground: Colors.white,
      );
    case RecordType.pump:
      return const _BadgeColors(
        background: Color(0xFF4fb186),
        foreground: Colors.white,
      );
    case RecordType.pee:
      return const _BadgeColors(
        background: Color(0xFFb6a000),
        foreground: Colors.white,
      );
    case RecordType.poop:
      return const _BadgeColors(
        background: Color(0xFF194e01),
        foreground: Colors.white,
      );
    case RecordType.temperature:
      return _BadgeColors(
        background: Colors.red.shade100,
        foreground: Colors.red.shade800,
      );
    case RecordType.other:
      return const _BadgeColors(
        background: Color(0xFF8f60ac),
        foreground: Colors.white,
      );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle =
        Theme.of(context).textTheme.labelSmall ?? const TextStyle(fontSize: 12);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: baseTextStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}
