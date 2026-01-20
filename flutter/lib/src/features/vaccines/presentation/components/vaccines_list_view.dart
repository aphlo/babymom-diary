import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_requirement.dart';

import '../models/vaccine_info.dart';
import '../styles/vaccine_type_styles.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../widgets/dose_status_badge.dart';
import '../widgets/vaccine_type_badge.dart';

class VaccinesListView extends StatelessWidget {
  const VaccinesListView({
    super.key,
    required this.vaccines,
    required this.recordsByVaccine,
    this.onVaccineTap,
    this.onDoseReservationTap,
    this.onScheduledDoseTap,
  });

  final List<VaccineInfo> vaccines;
  final Map<String, VaccinationRecord> recordsByVaccine;
  final ValueChanged<VaccineInfo>? onVaccineTap;
  final void Function(VaccineInfo vaccine, int doseNumber)?
      onDoseReservationTap;
  final void Function(
          VaccineInfo vaccine, int doseNumber, DoseStatusInfo statusInfo)?
      onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: vaccines.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final vaccine = vaccines[index];
        final record = recordsByVaccine[vaccine.id];
        return _VaccineListCard(
          vaccine: vaccine,
          record: record,
          onTap: onVaccineTap != null ? () => onVaccineTap!(vaccine) : null,
          onDoseReservationTap: onDoseReservationTap,
          onScheduledDoseTap: onScheduledDoseTap,
        );
      },
    );
  }
}

class _VaccineListCard extends StatelessWidget {
  const _VaccineListCard({
    required this.vaccine,
    this.record,
    this.onTap,
    this.onDoseReservationTap,
    this.onScheduledDoseTap,
  });

  final VaccineInfo vaccine;
  final VaccinationRecord? record;
  final VoidCallback? onTap;
  final void Function(VaccineInfo vaccine, int doseNumber)?
      onDoseReservationTap;
  final void Function(
          VaccineInfo vaccine, int doseNumber, DoseStatusInfo statusInfo)?
      onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isInfluenza = vaccine.id.startsWith('influenza');

    // Extract all dose numbers
    final Set<int> allDoseNumbers = <int>{};
    for (final doseNumbers in vaccine.doseSchedules.values) {
      allDoseNumbers.addAll(doseNumbers);
    }

    // For influenza, show all doses regardless of status
    final List<int> sortedDoseNumbers = isInfluenza
        ? (vaccine.id == 'influenza_injection'
            ? List<int>.generate(14, (index) => index + 1)
            : List<int>.generate(5, (index) => index + 1))
        : (allDoseNumbers.toList()..sort());

    final requirement =
        _RequirementPresentation.fromRequirement(vaccine.requirement, context);
    final typeStyles = vaccineTypeStyles(vaccine.category, context: context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    vaccine.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _RequirementBadge(presentation: requirement),
                const SizedBox(width: 4),
                VaccineTypeBadge(
                  label: typeStyles.label,
                  backgroundColor: typeStyles.backgroundColor,
                  foregroundColor: typeStyles.foregroundColor,
                  borderColor: typeStyles.borderColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  borderWidth: 0,
                ),
                if (onTap != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    color: context.subtextColor,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (isInfluenza)
            _InfluenzaDoseGrid(
              vaccine: vaccine,
              record: record,
              sortedDoseNumbers: sortedDoseNumbers,
              onDoseReservationTap: onDoseReservationTap,
              onScheduledDoseTap: onScheduledDoseTap,
            )
          else
            _StandardDoseList(
              vaccine: vaccine,
              record: record,
              sortedDoseNumbers: sortedDoseNumbers,
              onDoseReservationTap: onDoseReservationTap,
              onScheduledDoseTap: onScheduledDoseTap,
            ),
        ],
      ),
    );
  }
}

class _InfluenzaDoseGrid extends StatelessWidget {
  const _InfluenzaDoseGrid({
    required this.vaccine,
    this.record,
    required this.sortedDoseNumbers,
    this.onDoseReservationTap,
    this.onScheduledDoseTap,
  });

  final VaccineInfo vaccine;
  final VaccinationRecord? record;
  final List<int> sortedDoseNumbers;
  final void Function(VaccineInfo vaccine, int doseNumber)?
      onDoseReservationTap;
  final void Function(
          VaccineInfo vaccine, int doseNumber, DoseStatusInfo statusInfo)?
      onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Find the first unscheduled dose number
    final int? firstUnscheduledDoseNumber = _findFirstUnscheduledDose();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: sortedDoseNumbers.map((doseNumber) {
        final DoseStatusInfo? statusInfo =
            _getDoseStatusInfo(vaccine, doseNumber);
        final DoseBadgePresentation presentation =
            DoseBadgePresentation.fromStatus(statusInfo);
        final bool hasScheduledDate =
            (statusInfo?.status == DoseStatus.scheduled ||
                    statusInfo?.status == DoseStatus.completed) &&
                statusInfo?.scheduledDate != null;
        final DateTime? scheduledDate = statusInfo?.scheduledDate;
        final String dateLabel = hasScheduledDate && scheduledDate != null
            ? DateFormatter.yyMMdd(scheduledDate)
            : '--/--/--';

        // Only the first unscheduled dose can be tapped for reservation
        final bool canTap = onDoseReservationTap != null &&
            doseNumber == firstUnscheduledDoseNumber &&
            statusInfo?.status != DoseStatus.completed &&
            statusInfo?.status != DoseStatus.scheduled;
        final VoidCallback? tapHandler = canTap
            ? () => onDoseReservationTap!(vaccine, doseNumber)
            : (statusInfo?.status == DoseStatus.scheduled &&
                    onScheduledDoseTap != null &&
                    statusInfo != null)
                ? () => onScheduledDoseTap!(vaccine, doseNumber, statusInfo)
                : (statusInfo?.status == DoseStatus.completed &&
                        onScheduledDoseTap != null &&
                        statusInfo != null)
                    ? () => onScheduledDoseTap!(vaccine, doseNumber, statusInfo)
                    : null;

        // Active if it's the first unscheduled dose, scheduled, or completed
        final bool isActive = doseNumber == firstUnscheduledDoseNumber ||
            statusInfo?.status == DoseStatus.scheduled ||
            statusInfo?.status == DoseStatus.completed;

        return SizedBox(
          width: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 0.75,
                child: DoseStatusBadge(
                  presentation: presentation,
                  isActive: isActive,
                  onTap: tapHandler,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: hasScheduledDate
                      ? context.textPrimary
                      : context.inactiveTabColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  int? _findFirstUnscheduledDose() {
    for (final doseNumber in sortedDoseNumbers) {
      final DoseStatusInfo? statusInfo =
          _getDoseStatusInfo(vaccine, doseNumber);
      if (statusInfo?.status != DoseStatus.scheduled &&
          statusInfo?.status != DoseStatus.completed) {
        return doseNumber;
      }
    }
    return null;
  }

  DoseStatusInfo? _getDoseStatusInfo(VaccineInfo vaccine, int doseNumber) {
    final DoseStatus? status = vaccine.doseStatuses[doseNumber];
    if (status == null) {
      return null;
    }

    // Get full dose information from the record
    final DoseRecord? doseRecord = record?.getDoseByNumber(doseNumber);
    return DoseStatusInfo(
      doseNumber: doseNumber,
      status: status,
      scheduledDate: doseRecord?.scheduledDate,
      reservationGroupId: doseRecord?.reservationGroupId,
    );
  }
}

class _StandardDoseList extends StatelessWidget {
  const _StandardDoseList({
    required this.vaccine,
    this.record,
    required this.sortedDoseNumbers,
    this.onDoseReservationTap,
    this.onScheduledDoseTap,
  });

  final VaccineInfo vaccine;
  final VaccinationRecord? record;
  final List<int> sortedDoseNumbers;
  final void Function(VaccineInfo vaccine, int doseNumber)?
      onDoseReservationTap;
  final void Function(
          VaccineInfo vaccine, int doseNumber, DoseStatusInfo statusInfo)?
      onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (sortedDoseNumbers.isEmpty) {
      return const SizedBox.shrink();
    }

    // Find the first unscheduled dose number
    final int? firstUnscheduledDoseNumber = _findFirstUnscheduledDose();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: sortedDoseNumbers.map((doseNumber) {
        final statusInfo = _getDoseStatusInfo(vaccine, doseNumber);
        final presentation = DoseBadgePresentation.fromStatus(statusInfo);
        final DateTime? scheduledDate = statusInfo?.scheduledDate;
        final bool showDateLabel =
            (statusInfo?.status == DoseStatus.scheduled &&
                    scheduledDate != null) ||
                (statusInfo?.status == DoseStatus.completed &&
                    scheduledDate != null);
        final DateTime? effectiveDate = showDateLabel ? scheduledDate : null;
        final String dateLabel = effectiveDate != null
            ? DateFormatter.yyMMdd(effectiveDate)
            : '--/--/--';

        // Only the first unscheduled dose can be tapped for reservation
        final bool canTap = onDoseReservationTap != null &&
            doseNumber == firstUnscheduledDoseNumber &&
            statusInfo?.status != DoseStatus.completed &&
            statusInfo?.status != DoseStatus.scheduled;
        final VoidCallback? tapHandler = canTap
            ? () => onDoseReservationTap!(vaccine, doseNumber)
            : (statusInfo?.status == DoseStatus.scheduled &&
                    onScheduledDoseTap != null &&
                    statusInfo != null)
                ? () => onScheduledDoseTap!(vaccine, doseNumber, statusInfo)
                : (statusInfo?.status == DoseStatus.completed &&
                        onScheduledDoseTap != null &&
                        statusInfo != null)
                    ? () => onScheduledDoseTap!(vaccine, doseNumber, statusInfo)
                    : null;

        // Active if it's the first unscheduled dose, scheduled, or completed
        final bool isActive = doseNumber == firstUnscheduledDoseNumber ||
            statusInfo?.status == DoseStatus.scheduled ||
            statusInfo?.status == DoseStatus.completed;

        return SizedBox(
          width: 65,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 0.85,
                child: DoseStatusBadge(
                  presentation: presentation,
                  isActive: isActive,
                  onTap: tapHandler,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: effectiveDate != null
                      ? context.textPrimary
                      : context.inactiveTabColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  int? _findFirstUnscheduledDose() {
    for (final doseNumber in sortedDoseNumbers) {
      final DoseStatusInfo? statusInfo =
          _getDoseStatusInfo(vaccine, doseNumber);
      if (statusInfo?.status != DoseStatus.scheduled &&
          statusInfo?.status != DoseStatus.completed) {
        return doseNumber;
      }
    }
    return null;
  }

  DoseStatusInfo? _getDoseStatusInfo(VaccineInfo vaccine, int doseNumber) {
    final DoseStatus? status = vaccine.doseStatuses[doseNumber];
    if (status == null) {
      return null;
    }

    // Get full dose information from the record
    final DoseRecord? doseRecord = record?.getDoseByNumber(doseNumber);
    return DoseStatusInfo(
      doseNumber: doseNumber,
      status: status,
      scheduledDate: doseRecord?.scheduledDate,
      reservationGroupId: doseRecord?.reservationGroupId,
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
          fontSize: 10,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
