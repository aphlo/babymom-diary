import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../models/vaccine_info.dart';

/// ワクチン接種時の注意点セクション
///
/// ワクチン詳細ページで使用される
class VaccineNotesSection extends StatelessWidget {
  const VaccineNotesSection({
    super.key,
    required this.notes,
  });

  final List<VaccineGuidelineNote> notes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.infoBoxBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: context.infoBoxAccent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '接種時の注意点',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.infoBoxAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _VaccineNotesList(notes: notes),
        ],
      ),
    );
  }
}

class _VaccineNotesList extends StatelessWidget {
  const _VaccineNotesList({required this.notes});

  final List<VaccineGuidelineNote> notes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = context.infoBoxText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: notes.asMap().entries.map((entry) {
        final note = entry.value;
        final TextStyle? textStyle = textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: textColor,
        );

        return Padding(
          padding: EdgeInsets.only(top: entry.key == 0 ? 0 : 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 6,
                color: textColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  note.message,
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(growable: false),
    );
  }
}
