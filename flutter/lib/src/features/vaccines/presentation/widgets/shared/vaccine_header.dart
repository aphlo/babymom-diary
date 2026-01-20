import 'package:flutter/material.dart';

import '../../models/vaccine_info.dart';
import '../../styles/vaccine_type_styles.dart';
import 'requirement_badge.dart';
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
    final typeStyles = vaccineTypeStyles(vaccine.category, context: context);
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
        RequirementBadge(requirement: vaccine.requirement),
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
