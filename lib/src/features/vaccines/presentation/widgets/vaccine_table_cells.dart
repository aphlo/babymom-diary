import 'package:flutter/material.dart';

import '../models/vaccine_info.dart';
import '../styles/vaccine_type_styles.dart';
import 'vaccine_type_badge.dart';

class HeaderCornerCell extends StatelessWidget {
  const HeaderCornerCell({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class HeaderPeriodCell extends StatelessWidget {
  const HeaderPeriodCell({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class VaccineNameCell extends StatelessWidget {
  const VaccineNameCell({
    super.key,
    required this.vaccine,
  });

  final VaccineInfo vaccine;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    final VaccineTypeStyles styles =
        vaccineTypeStyles(vaccine.category, colorScheme);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            vaccine.name,
            style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          VaccineTypeBadge(
            label: styles.label,
            backgroundColor: styles.backgroundColor,
            foregroundColor: styles.foregroundColor,
            borderColor: styles.borderColor,
          ),
        ],
      ),
    );
  }
}

class EmptyScheduleCell extends StatelessWidget {
  const EmptyScheduleCell({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.width,
    required this.height,
    required this.border,
    required this.child,
    this.backgroundColor,
  });

  final double width;
  final double height;
  final Border border;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        border: border,
      ),
      child: child,
    );
  }
}
