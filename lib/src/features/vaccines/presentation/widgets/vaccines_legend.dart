import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;
import 'package:flutter/material.dart';
import '../styles/vaccine_type_styles.dart';
import 'vaccine_type_badge.dart';

class VaccinesLegend extends StatelessWidget {
  const VaccinesLegend({super.key});

  static const double _height = 64;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final BorderSide borderSide = BorderSide(
      color: colorScheme.outlineVariant.withOpacity(0.6),
      width: 0.5,
    );

    final VaccineTypeStyles liveStyles =
        vaccineTypeStyles(domain.VaccineCategory.live);
    final VaccineTypeStyles inactivatedStyles =
        vaccineTypeStyles(domain.VaccineCategory.inactivated);

    return Container(
      height: _height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: Border(top: borderSide),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '凡例',
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 4,
              children: <Widget>[
                _LegendItem(
                  styles: liveStyles,
                  description: '生ワクチン',
                ),
                _LegendItem(
                  styles: inactivatedStyles,
                  description: '不活化ワクチン',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.styles,
    required this.description,
  });

  final VaccineTypeStyles styles;
  final String description;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        VaccineTypeBadge(
          label: styles.label,
          backgroundColor: styles.backgroundColor,
          foregroundColor: styles.foregroundColor,
          borderColor: styles.borderColor,
        ),
        const SizedBox(width: 6),
        Text(
          description,
          style: textStyle,
        ),
      ],
    );
  }
}
