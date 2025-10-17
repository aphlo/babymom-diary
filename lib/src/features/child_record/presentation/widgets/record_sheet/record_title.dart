import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../child_record.dart';

class RecordTitle extends StatelessWidget {
  const RecordTitle({
    super.key,
    required this.record,
    this.onEdit,
    this.onDelete,
  });
  final Record record;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeText = DateFormat('HH:mm').format(record.at.toLocal());
    final noteText = record.note?.trim() ?? '';
    final hasNote = noteText.isNotEmpty;
    final tags = record.tags
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList(growable: false);
    final titleDetail = _buildTitleDetail(
      record,
      noteText: noteText,
      tags: tags,
    );
    final timeTextStyle = theme.textTheme.bodySmall
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant) ??
        const TextStyle(fontSize: 12, color: Colors.black54);
    final detailStyle = theme.textTheme.bodyMedium;
    final titleWidget = record.type == RecordType.other && titleDetail.usesTags
        ? _OtherRecordTitle(
            timeText: timeText,
            tags: tags,
            timeStyle: timeTextStyle,
          )
        : _RecordTitleRow(
            timeText: timeText,
            detail: titleDetail.detail,
            timeStyle: timeTextStyle,
            detailStyle: detailStyle,
          );
    final subtitleWidgets = <Widget>[];

    if (record.type == RecordType.other &&
        tags.isNotEmpty &&
        !titleDetail.usesTags) {
      subtitleWidgets.add(_TagStrip(tags: tags));
    }

    if (hasNote && !titleDetail.usesNote) {
      subtitleWidgets.add(
        Text(
          noteText,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    Widget? trailing;
    final actionButtons = <Widget>[];
    if (onEdit != null) {
      actionButtons.add(
        IconButton(
          onPressed: onEdit,
          tooltip: '編集',
          icon: const Icon(Icons.edit_outlined),
          visualDensity: VisualDensity.compact,
        ),
      );
    }
    if (onDelete != null) {
      actionButtons.add(
        IconButton(
          onPressed: onDelete,
          tooltip: '削除',
          icon: const Icon(Icons.delete_outline),
          visualDensity: VisualDensity.compact,
        ),
      );
    }
    if (actionButtons.isNotEmpty) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actionButtons,
        ],
      );
    }

    return ListTile(
      leading: Icon(switch (record.type) {
        RecordType.formula => Icons.local_drink,
        RecordType.pump => Icons.local_drink_outlined,
        RecordType.breastRight => Icons.child_care,
        RecordType.breastLeft => Icons.child_care,
        RecordType.pee => Icons.water_drop,
        RecordType.poop => Icons.delete_outline,
        RecordType.other => Icons.more_horiz,
      }),
      title: titleWidget,
      subtitle: subtitleWidgets.isEmpty
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: subtitleWidgets,
            ),
      isThreeLine: subtitleWidgets.length > 1,
      trailing: trailing,
    );
  }
}

class _RecordTitleRow extends StatelessWidget {
  const _RecordTitleRow({
    required this.timeText,
    required this.detail,
    required this.timeStyle,
    required this.detailStyle,
  });

  final String timeText;
  final String detail;
  final TextStyle timeStyle;
  final TextStyle? detailStyle;

  @override
  Widget build(BuildContext context) {
    final trimmedDetail = detail.trim();
    if (trimmedDetail.isEmpty) {
      return Text(
        timeText,
        style: timeStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Row(
      children: [
        Text(
          timeText,
          style: timeStyle,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            trimmedDetail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: detailStyle,
          ),
        ),
      ],
    );
  }
}

_TitleDetail _buildTitleDetail(
  Record record, {
  required String noteText,
  required List<String> tags,
}) {
  switch (record.type) {
    case RecordType.formula:
    case RecordType.pump:
      final amount = record.amount;
      return amount != null
          ? _TitleDetail(detail: '${amount.toStringAsFixed(0)} ml')
          : const _TitleDetail(detail: '量未入力');
    case RecordType.breastRight:
    case RecordType.breastLeft:
      final duration = _formatBreastDuration(record);
      return _TitleDetail(detail: duration);
    case RecordType.pee:
      final label = record.excretionVolume?.label;
      return _TitleDetail(detail: '尿 ($label)');
    case RecordType.poop:
      final label = record.excretionVolume?.label;
      return _TitleDetail(detail: '便 ($label)');
    case RecordType.other:
      if (tags.isNotEmpty) {
        return const _TitleDetail(
          detail: '',
          usesTags: true,
        );
      }
      if (noteText.isNotEmpty) {
        return _TitleDetail(
          detail: noteText,
          usesNote: true,
        );
      }
      return const _TitleDetail(detail: '');
  }
}

class _TitleDetail {
  const _TitleDetail({
    required this.detail,
    this.usesTags = false,
    this.usesNote = false,
  });

  final String detail;
  final bool usesTags;
  final bool usesNote;
}

class _OtherRecordTitle extends StatelessWidget {
  const _OtherRecordTitle({
    required this.timeText,
    required this.tags,
    required this.timeStyle,
  });

  final String timeText;
  final List<String> tags;
  final TextStyle timeStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          timeText,
          style: timeStyle,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TagStrip(tags: tags),
        ),
      ],
    );
  }
}

class _TagStrip extends StatelessWidget {
  const _TagStrip({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle =
        theme.textTheme.labelSmall ?? const TextStyle(fontSize: 12);
    final textStyle = baseStyle.copyWith(
      color: theme.colorScheme.onSecondaryContainer,
      fontWeight: FontWeight.w600,
    );
    final background = theme.colorScheme.secondaryContainer;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (var i = 0; i < tags.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            _TagChip(
              label: tags[i],
              background: background,
              textStyle: textStyle,
            ),
          ],
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.background,
    required this.textStyle,
  });

  final String label;
  final Color background;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: textStyle),
    );
  }
}

String _formatBreastDuration(Record record) {
  final amount = record.amount;

  if (amount != null) {
    if (amount <= 0) return '';
    if (amount > 0) {
      return '$amount分';
    }
  }
  return '';
}
