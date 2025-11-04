import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../../domain/entities/dose_record.dart';
import '../../domain/value_objects/influenza_season.dart';
import '../models/vaccine_detail_callbacks.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import 'dose_status_badge.dart';

class InfluenzaDoseReservationBoard extends StatelessWidget {
  const InfluenzaDoseReservationBoard({
    super.key,
    required this.seasons,
    required this.doseNumbers,
    required this.doseStatuses,
    this.activeDoseNumber,
    this.pendingDoseNumber,
    this.vaccine,
    this.onReservationTap,
    this.onScheduledDoseTap,
  });

  final List<InfluenzaSeasonSchedule> seasons;
  final List<int> doseNumbers;
  final Map<int, DoseStatusInfo> doseStatuses;
  final int? activeDoseNumber;
  final int? pendingDoseNumber;
  final VaccineInfo? vaccine;
  final VaccineReservationTap? onReservationTap;
  final ScheduledDoseTap? onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (seasons.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<int> sortedDoseNumbers = List<int>.of(doseNumbers)..sort();
    final bool hasPending = pendingDoseNumber != null &&
        sortedDoseNumbers.contains(pendingDoseNumber);
    final int? resolvedActiveDose = hasPending
        ? pendingDoseNumber
        : ((activeDoseNumber != null &&
                sortedDoseNumbers.contains(activeDoseNumber))
            ? activeDoseNumber
            : sortedDoseNumbers.first);

    final List<InfluenzaSeasonSchedule> sortedSeasons =
        List<InfluenzaSeasonSchedule>.of(seasons)
          ..sort(
            (InfluenzaSeasonSchedule a, InfluenzaSeasonSchedule b) =>
                a.seasonIndex.compareTo(b.seasonIndex),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(sortedSeasons.length, (int index) {
        final InfluenzaSeasonSchedule season = sortedSeasons[index];
        final String seasonLabel = season.seasonLabel();
        final int firstDoseNumber = season.firstDoseNumber;
        final int secondDoseNumber = season.secondDoseNumber;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == sortedSeasons.length - 1 ? 0 : 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 72,
                child: Text(
                  seasonLabel,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _InfluenzaDoseCell(
                        doseNumber: firstDoseNumber,
                        doseStatuses: doseStatuses,
                        displayOrder: 1,
                        isActive: true,
                        seasonLabel: seasonLabel,
                        vaccine: vaccine,
                        onReservationTap: onReservationTap,
                        onScheduledDoseTap: onScheduledDoseTap,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _InfluenzaDoseCell(
                        doseNumber: secondDoseNumber,
                        doseStatuses: doseStatuses,
                        displayOrder: 2,
                        isActive: resolvedActiveDose == secondDoseNumber ||
                            (doseStatuses[firstDoseNumber]?.status ==
                                    DoseStatus.completed &&
                                doseStatuses[secondDoseNumber]?.status == null),
                        seasonLabel: seasonLabel,
                        vaccine: vaccine,
                        onReservationTap: onReservationTap,
                        onScheduledDoseTap: onScheduledDoseTap,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InfluenzaDoseCell extends StatelessWidget {
  const _InfluenzaDoseCell({
    required this.doseNumber,
    required this.doseStatuses,
    required this.isActive,
    required this.displayOrder,
    required this.seasonLabel,
    this.vaccine,
    this.onReservationTap,
    this.onScheduledDoseTap,
  });

  final int doseNumber;
  final Map<int, DoseStatusInfo> doseStatuses;
  final bool isActive;
  final int displayOrder;
  final String seasonLabel;
  final VaccineInfo? vaccine;
  final VaccineReservationTap? onReservationTap;
  final ScheduledDoseTap? onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DoseStatusInfo? statusInfo = doseStatuses[doseNumber];
    final DoseBadgePresentation presentation =
        DoseBadgePresentation.fromStatus(statusInfo);

    final bool canTap = isActive &&
        vaccine != null &&
        onReservationTap != null &&
        statusInfo?.status != DoseStatus.completed;
    final DateTime? scheduledDate = statusInfo?.scheduledDate;
    final bool showScheduledLabel =
        statusInfo?.status == DoseStatus.scheduled && scheduledDate != null;
    final DateTime? effectiveDate = showScheduledLabel ? scheduledDate : null;
    final String? scheduledYearLabel =
        effectiveDate != null ? DateFormatter.yyyy(effectiveDate) : null;
    final String? scheduledDateLabel =
        effectiveDate != null ? DateFormatter.mmddE(effectiveDate) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$displayOrder回目',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DoseStatusBadge(
                presentation: presentation,
                isActive: isActive,
                onTap: canTap
                    ? () => onReservationTap!(
                          context,
                          vaccine!,
                          doseNumber,
                          influenzaSeasonLabel: seasonLabel,
                          influenzaDoseOrder: displayOrder,
                        )
                    : (statusInfo?.status == DoseStatus.scheduled &&
                            onScheduledDoseTap != null)
                        ? () => onScheduledDoseTap!(
                              context,
                              vaccine!,
                              doseNumber,
                              statusInfo!,
                              influenzaSeasonLabel: seasonLabel,
                              influenzaDoseOrder: displayOrder,
                            )
                        : null,
              ),
            ),
          ],
        ),
        if (scheduledYearLabel != null && scheduledDateLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheduledYearLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  scheduledDateLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
