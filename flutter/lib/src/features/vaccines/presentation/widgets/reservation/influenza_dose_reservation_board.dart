import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../../../domain/entities/dose_record.dart';
import '../../models/vaccine_detail_callbacks.dart';
import '../../models/vaccine_info.dart';
import '../../viewmodels/vaccine_detail_state.dart';
import '../shared/dose_status_badge.dart';

class InfluenzaDoseReservationBoard extends StatelessWidget {
  const InfluenzaDoseReservationBoard({
    super.key,
    required this.doseNumbers,
    required this.doseStatuses,
    this.activeDoseNumber,
    this.pendingDoseNumber,
    this.vaccine,
    this.onReservationTap,
    this.onScheduledDoseTap,
  });

  final List<int> doseNumbers;
  final Map<int, DoseStatusInfo> doseStatuses;
  final int? activeDoseNumber;
  final int? pendingDoseNumber;
  final VaccineInfo? vaccine;
  final VaccineReservationTap? onReservationTap;
  final ScheduledDoseTap? onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final List<int> sortedDoseNumbers = List<int>.of(doseNumbers)..sort();

    if (sortedDoseNumbers.isEmpty) {
      return const SizedBox.shrink();
    }

    final bool hasPending = pendingDoseNumber != null &&
        sortedDoseNumbers.contains(pendingDoseNumber);
    final int? resolvedActiveDose = hasPending
        ? pendingDoseNumber
        : ((activeDoseNumber != null &&
                sortedDoseNumbers.contains(activeDoseNumber))
            ? activeDoseNumber
            : sortedDoseNumbers.first);

    // 1行4個のグリッドレイアウト
    final int columns = 4;
    final int rows = (sortedDoseNumbers.length / columns).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(rows, (rowIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: rowIndex == rows - 1 ? 0 : 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(columns, (colIndex) {
              final int index = rowIndex * columns + colIndex;
              if (index >= sortedDoseNumbers.length) {
                // 空のセル
                return const Expanded(child: SizedBox.shrink());
              }

              final int doseNumber = sortedDoseNumbers[index];
              return Expanded(
                child: _InfluenzaDoseCell(
                  doseNumber: doseNumber,
                  doseStatuses: doseStatuses,
                  isActive: doseNumber == resolvedActiveDose,
                  vaccine: vaccine,
                  onReservationTap: onReservationTap,
                  onScheduledDoseTap: onScheduledDoseTap,
                ),
              );
            }),
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
    this.vaccine,
    this.onReservationTap,
    this.onScheduledDoseTap,
  });

  final int doseNumber;
  final Map<int, DoseStatusInfo> doseStatuses;
  final bool isActive;
  final VaccineInfo? vaccine;
  final VaccineReservationTap? onReservationTap;
  final ScheduledDoseTap? onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DoseStatusInfo? statusInfo = doseStatuses[doseNumber];
    final DoseBadgePresentation presentation =
        DoseBadgePresentation.fromStatus(statusInfo);

    // 予約済みや接種済みの場合は常にactiveな見た目にする
    final bool effectiveIsActive = isActive ||
        statusInfo?.status == DoseStatus.scheduled ||
        statusInfo?.status == DoseStatus.completed;

    final bool canTap = isActive &&
        vaccine != null &&
        onReservationTap != null &&
        statusInfo?.status != DoseStatus.completed &&
        statusInfo?.status != DoseStatus.scheduled;
    final DateTime? scheduledDate = statusInfo?.scheduledDate;
    final bool hasScheduledDate = (statusInfo?.status == DoseStatus.scheduled ||
            statusInfo?.status == DoseStatus.completed) &&
        scheduledDate != null;

    // 日付表示用のラベル
    final String dateYearLabel =
        hasScheduledDate ? DateFormatter.yyyy(scheduledDate) : '----年';
    final String dateDateLabel =
        hasScheduledDate ? DateFormatter.mmddE(scheduledDate) : '--月--日(-)';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 回数表示
        Text(
          '$doseNumber回目',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        // ステータスバッジ
        DoseStatusBadge(
          presentation: presentation,
          isActive: effectiveIsActive,
          onTap: canTap
              ? () => onReservationTap!(
                    context,
                    vaccine!,
                    doseNumber,
                  )
              : (statusInfo?.status == DoseStatus.scheduled &&
                      onScheduledDoseTap != null)
                  ? () => onScheduledDoseTap!(
                        context,
                        vaccine!,
                        doseNumber,
                        statusInfo!,
                      )
                  : (statusInfo?.status == DoseStatus.completed &&
                          onScheduledDoseTap != null)
                      ? () => onScheduledDoseTap!(
                            context,
                            vaccine!,
                            doseNumber,
                            statusInfo!,
                          )
                      : null,
        ),
        const SizedBox(height: 8),
        // 日付表示（2行）
        SizedBox(
          width: 88,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dateYearLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: hasScheduledDate
                      ? context.doseDateLabel
                      : context.doseDatePlaceholder,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                dateDateLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: hasScheduledDate
                      ? context.doseDateLabel
                      : context.doseDatePlaceholder,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
