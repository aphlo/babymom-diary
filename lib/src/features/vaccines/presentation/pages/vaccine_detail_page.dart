import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;
import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../models/vaccine_info.dart';
import '../styles/vaccine_type_styles.dart';
import '../utils/vaccination_period_calculator.dart';
import '../widgets/vaccine_type_badge.dart';

class VaccineDetailPage extends StatelessWidget {
  const VaccineDetailPage({
    super.key,
    required this.vaccine,
    this.childBirthday,
  });

  final VaccineInfo vaccine;
  final DateTime? childBirthday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dosePeriodMap = _extractDosePeriods(vaccine);
    final doseNumbers = dosePeriodMap.keys.toList()..sort();

    final requirement =
        _RequirementPresentation.fromRequirement(vaccine.requirement);
    final typeStyles = vaccineTypeStyles(vaccine.category);
    final TextStyle nameTextStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ) ??
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(vaccine.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 8),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            vaccine.name,
                            style: nameTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _RequirementBadge(presentation: requirement),
                      const SizedBox(width: 8),
                      VaccineTypeBadge(
                        label: typeStyles.label,
                        backgroundColor: typeStyles.backgroundColor,
                        foregroundColor: typeStyles.foregroundColor,
                        borderColor: typeStyles.borderColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        borderWidth: 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (doseNumbers.isEmpty)
                    Text(
                      '接種回数の情報が見つかりませんでした',
                      style: theme.textTheme.bodyMedium,
                    )
                  else
                    VaccineDoseReservationBoard(
                      doseNumbers: doseNumbers,
                      periodsByDose: dosePeriodMap,
                      childBirthday: childBirthday,
                    ),
                  if (vaccine.notes.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      '接種時の注意点',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _VaccineNotesList(notes: vaccine.notes),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<int, List<String>> _extractDosePeriods(VaccineInfo vaccine) {
    final Map<int, List<String>> result = <int, List<String>>{};
    vaccine.doseSchedules.forEach((String periodLabel, List<int> doses) {
      for (final int dose in doses) {
        final periods = result.putIfAbsent(dose, () => <String>[]);
        if (!periods.contains(periodLabel)) {
          periods.add(periodLabel);
        }
      }
    });
    return result;
  }
}

class VaccineDoseReservationBoard extends StatelessWidget {
  const VaccineDoseReservationBoard({
    super.key,
    required this.doseNumbers,
    required this.periodsByDose,
    this.activeDoseIndex = 0,
    this.childBirthday,
  });

  final List<int> doseNumbers;
  final Map<int, List<String>> periodsByDose;
  final int activeDoseIndex;
  final DateTime? childBirthday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedActiveIndex =
        activeDoseIndex.clamp(0, doseNumbers.length - 1);
    final int doseCount = doseNumbers.length;
    final Color activeColor = theme.colorScheme.primary;
    final Color inactiveColor = Colors.grey.shade400;
    final double pointerAlignmentX = doseCount == 0
        ? 0
        : ((normalizedActiveIndex + 0.5) / doseCount) * 2 - 1;
    final List<String> activeLabels = doseCount == 0
        ? const <String>[]
        : periodsByDose[doseNumbers[normalizedActiveIndex]] ?? const <String>[];
    final String recommendationText = _buildRecommendationText(
      labels: activeLabels,
      childBirthday: childBirthday,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < doseNumbers.length; i++)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${doseNumbers[i]}回目',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _DoseStatusBadge(
                      color: i == normalizedActiveIndex
                          ? activeColor
                          : inactiveColor,
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (doseCount > 0)
          _DoseRecommendationBubble(
            text: recommendationText,
            alignmentX: pointerAlignmentX.clamp(-1.0, 1.0),
          ),
      ],
    );
  }
}

String _buildRecommendationText({
  required List<String> labels,
  required DateTime? childBirthday,
}) {
  if (labels.isEmpty) {
    return '接種時期の情報がありません';
  }

  final DateRange? range = VaccinationPeriodCalculator.dateRangeForLabels(
    birthday: childBirthday,
    labels: labels,
  );
  if (range == null || range.end.isBefore(range.start)) {
    return _fallbackRecommendationText(labels);
  }

  final String startText = DateFormatter.yyyyMMddE(range.start);
  final String endText = DateFormatter.yyyyMMddE(range.end);

  if (range.start.isAtSameMomentAs(range.end)) {
    return '接種時期のめやす\n$startText';
  }
  return '接種時期のめやす\n$startText〜\n$endText';
}

String _fallbackRecommendationText(List<String> labels) {
  if (labels.length == 1) {
    return '接種時期のめやす\n${labels.first}ごろ';
  }
  return '接種時期のめやす\n${labels.first} 〜 ${labels.last}ごろ';
}

class _VaccineNotesList extends StatelessWidget {
  const _VaccineNotesList({required this.notes});

  final List<VaccineGuidelineNote> notes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: notes.asMap().entries.map((entry) {
        final note = entry.value;
        final Color accentColor =
            note.isAttention ? AppColors.secondary : colorScheme.outline;
        final TextStyle? textStyle = textTheme.bodyMedium?.copyWith(
          fontWeight: note.isAttention ? FontWeight.w600 : FontWeight.w400,
          color: note.isAttention
              ? AppColors.secondary
              : textTheme.bodyMedium?.color,
        );

        return Padding(
          padding: EdgeInsets.only(top: entry.key == 0 ? 0 : 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Icon(
                  Icons.circle,
                  size: 6,
                  color: accentColor,
                ),
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

class _DoseStatusBadge extends StatelessWidget {
  const _DoseStatusBadge({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ) ??
        TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 12);

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.vaccines,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text('未定', style: textStyle),
        ],
      ),
    );
  }
}

class _DoseRecommendationBubble extends StatelessWidget {
  const _DoseRecommendationBubble({
    required this.text,
    required this.alignmentX,
  });

  final String text;
  final double alignmentX;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color backgroundColor = Colors.orange.shade50;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  offset: Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Align(
            alignment: Alignment(alignmentX, -1),
            child: SizedBox(
              width: 18,
              height: 10,
              child: CustomPaint(
                painter: _BubblePointerPainter(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubblePointerPainter extends CustomPainter {
  const _BubblePointerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BubblePointerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _RequirementBadge extends StatelessWidget {
  const _RequirementBadge({required this.presentation});

  final _RequirementPresentation presentation;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: presentation.foregroundColor,
            ) ??
        TextStyle(
          fontWeight: FontWeight.w700,
          color: presentation.foregroundColor,
          fontSize: 12,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: presentation.backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(presentation.label, style: textStyle),
    );
  }
}

class _RequirementPresentation {
  const _RequirementPresentation({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  static _RequirementPresentation fromRequirement(
      domain.VaccineRequirement requirement) {
    switch (requirement) {
      case domain.VaccineRequirement.mandatory:
        return const _RequirementPresentation(
          label: '定期接種',
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        );
      case domain.VaccineRequirement.optional:
        return const _RequirementPresentation(
          label: '任意接種',
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
        );
    }
  }
}
