import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../child_record.dart';

class RecordTitle extends StatelessWidget {
  const RecordTitle({super.key, required this.record});
  final Record record;

  @override
  Widget build(BuildContext context) {
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
    final titleWidget = record.type == RecordType.other && titleDetail.usesTags
        ? _OtherRecordTitle(timeText: timeText, tags: tags)
        : Text(
            _composeTitleText(timeText, titleDetail.detail),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
      trailing: hasNote ? const Icon(Icons.sticky_note_2_outlined) : null,
    );
  }
}

String _composeTitleText(String timeText, String detail) {
  final trimmedDetail = detail.trim();
  if (trimmedDetail.isEmpty) {
    return timeText;
  }
  return '$timeText $trimmedDetail';
}

_TitleDetail _buildTitleDetail(
  Record record, {
  required String noteText,
  required List<String> tags,
}) {
  switch (record.type) {
    case RecordType.formula:
      final amount = record.amount;
      return amount != null
          ? _TitleDetail(detail: '${amount.toStringAsFixed(0)} ml')
          : const _TitleDetail(detail: '量未入力');
    case RecordType.pump:
      final amount = record.amount;
      return amount != null
          ? _TitleDetail(detail: '搾母乳 ${amount.toStringAsFixed(0)} ml')
          : const _TitleDetail(detail: '搾母乳');
    case RecordType.breastRight:
      final duration = _formatBreastDuration(record);
      return duration.isEmpty
          ? const _TitleDetail(detail: '母乳(右)')
          : _TitleDetail(detail: '母乳(右) $duration');
    case RecordType.breastLeft:
      final duration = _formatBreastDuration(record);
      return duration.isEmpty
          ? const _TitleDetail(detail: '母乳(左)')
          : _TitleDetail(detail: '母乳(左) $duration');
    case RecordType.pee:
      final label = record.excretionVolume?.label;
      return label == null
          ? const _TitleDetail(detail: '尿')
          : _TitleDetail(detail: '尿 ($label)');
    case RecordType.poop:
      final label = record.excretionVolume?.label;
      return label == null
          ? const _TitleDetail(detail: '便')
          : _TitleDetail(detail: '便 ($label)');
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
  });

  final String timeText;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(timeText),
        const SizedBox(width: 8),
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
  final totalSeconds =
      record.durationSeconds ?? ((record.amount ?? 0) * 60).round();
  if (totalSeconds <= 0) {
    return '';
  }
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  final buffer = <String>[];
  if (minutes > 0) {
    buffer.add('$minutes分');
  }
  if (seconds > 0) {
    buffer.add('$seconds秒');
  }
  return buffer.join();
}
