import 'package:flutter/material.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;

import '../models/vaccine_info.dart';
import '../styles/vaccine_schedule_highlight_styles.dart';
import 'vaccine_table_cells.dart';

const double _legendLabelMaxWidth = 140;
const double _legendLabelNarrowWidth = 96;

class VaccinesLegend extends StatelessWidget {
  const VaccinesLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final BorderSide borderSide = BorderSide(
      color: colorScheme.outlineVariant.withOpacity(0.6),
      width: 0.5,
    );

    final VaccinePeriodHighlightStyle recommendedPrimaryStyle =
        vaccinePeriodHighlightStyle(
      highlight: domain.VaccinationPeriodHighlight.recommended,
      palette: VaccineHighlightPalette.primary,
    );
    final VaccinePeriodHighlightStyle recommendedSecondaryStyle =
        vaccinePeriodHighlightStyle(
      highlight: domain.VaccinationPeriodHighlight.recommended,
      palette: VaccineHighlightPalette.secondary,
    );
    final VaccinePeriodHighlightStyle availablePrimaryStyle =
        vaccinePeriodHighlightStyle(
      highlight: domain.VaccinationPeriodHighlight.available,
      palette: VaccineHighlightPalette.primary,
    );
    final VaccinePeriodHighlightStyle availableSecondaryStyle =
        vaccinePeriodHighlightStyle(
      highlight: domain.VaccinationPeriodHighlight.available,
      palette: VaccineHighlightPalette.secondary,
    );
    final VaccinePeriodHighlightStyle academyRecommendationStyle =
        vaccinePeriodHighlightStyle(
      highlight: domain.VaccinationPeriodHighlight.academyRecommendation,
      palette: VaccineHighlightPalette.primary,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: Border(top: borderSide),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: <Widget>[
              _DoseSequenceLegend(
                label: '一般的な接種時期',
                textStyle: textTheme.labelSmall,
                badgeFillColor: recommendedPrimaryStyle.badgeFillColor,
                badgeTextColor: recommendedPrimaryStyle.badgeTextColor,
                badgeBorderColor: recommendedPrimaryStyle.badgeBorderColor,
                doseNumbers: const <int>[1],
              ),
              _StatusLegend(
                label: '接種予定',
                status: DoseStatus.scheduled,
                textStyle: textTheme.labelSmall,
                baseBorderColor: recommendedPrimaryStyle.badgeBorderColor,
              ),
              _StatusLegend(
                label: '接種済み',
                status: DoseStatus.completed,
                textStyle: textTheme.labelSmall,
                baseBorderColor: recommendedPrimaryStyle.badgeBorderColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: <Widget>[
              _ColorLegend(
                label: '標準的な\n接種期間',
                textStyle: textTheme.labelSmall,
                colors: <Color>[
                  recommendedPrimaryStyle.cellColor,
                  recommendedSecondaryStyle.cellColor,
                ],
                labelMaxWidth: _legendLabelNarrowWidth,
                labelMaxLines: 2,
              ),
              _ColorLegend(
                label: '接種可能な\n期間',
                textStyle: textTheme.labelSmall,
                colors: <Color>[
                  availablePrimaryStyle.cellColor,
                  availableSecondaryStyle.cellColor,
                ],
                labelMaxWidth: _legendLabelNarrowWidth,
                labelMaxLines: 2,
              ),
              _ColorLegend(
                label: '小児科学会として\n推奨する期間',
                color: academyRecommendationStyle.cellColor,
                textStyle: textTheme.labelSmall,
                labelMaxWidth: _legendLabelNarrowWidth,
                labelMaxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DoseSequenceLegend extends StatelessWidget {
  const _DoseSequenceLegend({
    required this.label,
    required this.textStyle,
    required this.badgeFillColor,
    required this.badgeTextColor,
    required this.badgeBorderColor,
    required this.doseNumbers,
  });

  final String label;
  final TextStyle? textStyle;
  final Color badgeFillColor;
  final Color badgeTextColor;
  final Color badgeBorderColor;
  final List<int> doseNumbers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: doseNumbers
              .map(
                (int number) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: DoseNumberBadge(
                    number: number,
                    backgroundColor: badgeFillColor,
                    textColor: badgeTextColor,
                    borderColor: badgeBorderColor,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(width: 6),
        _LegendLabel(
          text: label,
          style: textStyle?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ColorLegend extends StatelessWidget {
  const _ColorLegend({
    required this.label,
    required this.textStyle,
    this.color,
    this.colors,
    this.labelMaxWidth,
    this.labelMaxLines,
  });

  final String label;
  final TextStyle? textStyle;
  final Color? color;
  final List<Color>? colors;
  final double? labelMaxWidth;
  final int? labelMaxLines;

  @override
  Widget build(BuildContext context) {
    assert(
      (color != null) ^ (colors != null),
      'Either color or colors must be provided.',
    );
    assert(
      colors == null || colors!.length == 2,
      'colors must contain exactly two items when provided.',
    );

    final List<Color>? gradientColors = colors;
    final BoxDecoration decoration = BoxDecoration(
      color: gradientColors == null ? color : null,
      gradient: gradientColors == null
          ? null
          : LinearGradient(
              colors: <Color>[
                gradientColors[0],
                gradientColors[0],
                gradientColors[1],
                gradientColors[1],
              ],
              stops: const <double>[0.0, 0.5, 0.5, 1.0],
            ),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: Colors.black.withOpacity(0.1),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 32,
          height: 18,
          decoration: decoration,
        ),
        const SizedBox(width: 6),
        _LegendLabel(
          text: label,
          style: textStyle?.copyWith(fontWeight: FontWeight.w500),
          maxWidth: labelMaxWidth ?? _legendLabelMaxWidth,
          maxLines: labelMaxLines ?? 3,
        ),
      ],
    );
  }
}

class _StatusLegend extends StatelessWidget {
  const _StatusLegend({
    required this.label,
    required this.status,
    required this.textStyle,
    required this.baseBorderColor,
  });

  final String label;
  final DoseStatus status;
  final TextStyle? textStyle;
  final Color baseBorderColor;

  @override
  Widget build(BuildContext context) {
    final TextStyle? resolvedStyle =
        textStyle?.copyWith(fontWeight: FontWeight.w500);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DoseNumberBadge(
          number: 1,
          backgroundColor: Colors.white,
          borderColor: baseBorderColor,
          status: status,
          textColor:
              status == DoseStatus.scheduled || status == DoseStatus.completed
                  ? Colors.white
                  : null,
        ),
        const SizedBox(width: 6),
        _LegendLabel(
          text: label,
          style: resolvedStyle,
        ),
      ],
    );
  }
}

class _LegendLabel extends StatelessWidget {
  const _LegendLabel({
    required this.text,
    required this.style,
    this.maxWidth = _legendLabelMaxWidth,
    this.maxLines = 3,
  });

  final String text;
  final TextStyle? style;
  final double maxWidth;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(
        text,
        style: style,
        softWrap: true,
        maxLines: maxLines,
      ),
    );
  }
}
