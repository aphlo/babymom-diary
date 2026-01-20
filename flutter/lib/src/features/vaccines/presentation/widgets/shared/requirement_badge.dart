import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../domain/value_objects/vaccine_requirement.dart';

/// 定期接種/任意接種バッジ
///
/// ワクチン一覧、ワクチン詳細ページ、予約ページで共通して使用される
class RequirementBadge extends StatelessWidget {
  const RequirementBadge({
    super.key,
    required this.requirement,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.fontSize,
  });

  final VaccineRequirement requirement;
  final EdgeInsetsGeometry padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final presentation =
        _RequirementPresentation.fromRequirement(requirement, context);
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: presentation.foregroundColor,
              fontSize: fontSize,
            ) ??
        TextStyle(
          fontWeight: FontWeight.w700,
          color: presentation.foregroundColor,
          fontSize: fontSize ?? 12,
        );

    return Container(
      padding: padding,
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
      VaccineRequirement requirement, BuildContext context) {
    switch (requirement) {
      case VaccineRequirement.mandatory:
        return _RequirementPresentation(
          label: '定期接種',
          backgroundColor: context.mandatoryBadgeBackground,
          foregroundColor: context.mandatoryBadgeText,
        );
      case VaccineRequirement.optional:
        return _RequirementPresentation(
          label: '任意接種',
          backgroundColor: context.optionalBadgeBackground,
          foregroundColor: context.optionalBadgeText,
        );
    }
  }
}
