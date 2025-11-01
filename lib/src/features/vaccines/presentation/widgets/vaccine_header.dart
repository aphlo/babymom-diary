import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/vaccine_info.dart';
import '../styles/vaccine_type_styles.dart';
import '../../domain/entities/vaccine.dart' as domain;
import 'vaccine_type_badge.dart';

class VaccineHeader extends StatelessWidget {
  const VaccineHeader({
    super.key,
    required this.vaccine,
  });

  final VaccineInfo vaccine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requirement =
        _RequirementPresentation.fromRequirement(vaccine.requirement);
    final typeStyles = vaccineTypeStyles(vaccine.category);
    final TextStyle nameTextStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ) ??
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

    return Row(
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
    );
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
