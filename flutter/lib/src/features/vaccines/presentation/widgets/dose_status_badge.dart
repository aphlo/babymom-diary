import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';

import '../../domain/entities/dose_record.dart';
import '../viewmodels/vaccine_detail_state.dart';

class DoseBadgePresentation {
  const DoseBadgePresentation({
    required this.label,
    required this.baseColor,
    required this.icon,
    required this.status,
  });

  final String label;
  final Color baseColor;
  final IconData icon;
  final DoseStatus? status;

  static DoseBadgePresentation fromStatus(DoseStatusInfo? info) {
    switch (info?.status) {
      case DoseStatus.completed:
        return const DoseBadgePresentation(
          label: '接種済',
          baseColor: Colors.green,
          icon: Icons.check_circle,
          status: DoseStatus.completed,
        );
      case DoseStatus.scheduled:
        return const DoseBadgePresentation(
          label: '予約済',
          baseColor: AppColors.reserved,
          icon: Icons.event_available,
          status: DoseStatus.scheduled,
        );
      default:
        return const DoseBadgePresentation(
          label: '未定',
          baseColor: Colors.grey,
          icon: Icons.vaccines,
          status: null,
        );
    }
  }
}

class DoseStatusBadge extends StatelessWidget {
  const DoseStatusBadge({
    super.key,
    required this.presentation,
    required this.isActive,
    this.onTap,
  });

  final DoseBadgePresentation presentation;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color baseColor = presentation.baseColor;
    final bool highlightWithPrimary = presentation.status == null && isActive;
    final Color activeColor =
        highlightWithPrimary ? theme.colorScheme.primary : baseColor;
    final Color effectiveColor = isActive ? activeColor : baseColor;
    final Color borderColor =
        isActive ? effectiveColor : baseColor.withValues(alpha: 0.6);
    final Color backgroundColor = isActive
        ? effectiveColor.withValues(alpha: 0.15)
        : baseColor.withValues(alpha: 0.08);
    final TextStyle textStyle = theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: borderColor,
        ) ??
        TextStyle(
          fontWeight: FontWeight.w700,
          color: borderColor,
          fontSize: 12,
        );

    final widget = Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor, width: isActive ? 1.8 : 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            presentation.icon,
            color: borderColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(presentation.label, style: textStyle),
        ],
      ),
    );

    if (onTap == null) {
      return widget;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: widget,
    );
  }
}
