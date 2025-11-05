import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../../domain/entities/dose_record.dart';
import '../models/vaccine_detail_callbacks.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import 'dose_status_badge.dart';

class VaccineDoseReservationBoard extends StatelessWidget {
  const VaccineDoseReservationBoard({
    super.key,
    required this.doseNumbers,
    required this.doseStatuses,
    this.activeDoseNumber,
    this.pendingDoseNumber,
    this.recommendationText,
    this.vaccine,
    this.onReservationTap,
    this.onScheduledDoseTap,
  });

  final List<int> doseNumbers;
  final Map<int, DoseStatusInfo> doseStatuses;
  final int? activeDoseNumber;
  final int? pendingDoseNumber;
  final String? recommendationText;
  final VaccineInfo? vaccine;
  final VaccineReservationTap? onReservationTap;
  final ScheduledDoseTap? onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final int doseCount = doseNumbers.length;

    final bool hasPending =
        pendingDoseNumber != null && doseNumbers.contains(pendingDoseNumber);
    final int? resolvedActiveDose = hasPending
        ? pendingDoseNumber
        : ((activeDoseNumber != null && doseNumbers.contains(activeDoseNumber))
            ? activeDoseNumber
            : (doseCount > 0 ? doseNumbers.first : null));
    final int normalizedActiveIndex = doseCount == 0
        ? 0
        : doseNumbers
            .indexOf(resolvedActiveDose ?? doseNumbers.first)
            .clamp(0, doseCount - 1);
    final double pointerAlignmentX = doseCount == 0
        ? 0
        : ((normalizedActiveIndex + 0.5) / doseCount) * 2 - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < doseNumbers.length; i++)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${doseNumbers[i]}回目',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Builder(
                      builder: (context) {
                        final statusInfo = doseStatuses[doseNumbers[i]];
                        final presentation =
                            DoseBadgePresentation.fromStatus(statusInfo);
                        // 予約済みや接種済みの場合は常にactiveな見た目にする
                        final bool isActive = i == normalizedActiveIndex ||
                            statusInfo?.status == DoseStatus.scheduled ||
                            statusInfo?.status == DoseStatus.completed;
                        final bool canTap = i == normalizedActiveIndex &&
                            vaccine != null &&
                            onReservationTap != null &&
                            statusInfo?.status != DoseStatus.completed &&
                            statusInfo?.status != DoseStatus.scheduled;
                        final DateTime? scheduledDate =
                            statusInfo?.scheduledDate;
                        final bool showDateLabel =
                            (statusInfo?.status == DoseStatus.scheduled &&
                                    scheduledDate != null) ||
                                (statusInfo?.status == DoseStatus.completed &&
                                    scheduledDate != null);
                        final DateTime? effectiveDate =
                            showDateLabel ? scheduledDate : null;
                        final String? dateYearLabel = effectiveDate != null
                            ? DateFormatter.yyyy(effectiveDate)
                            : null;
                        final String? dateDateLabel = effectiveDate != null
                            ? DateFormatter.mmddE(effectiveDate)
                            : null;
                        return Column(
                          children: [
                            DoseStatusBadge(
                              presentation: presentation,
                              isActive: isActive,
                              onTap: canTap
                                  ? () => onReservationTap!(
                                        context,
                                        vaccine!,
                                        doseNumbers[i],
                                      )
                                  : (statusInfo?.status ==
                                              DoseStatus.scheduled &&
                                          onScheduledDoseTap != null)
                                      ? () => onScheduledDoseTap!(
                                            context,
                                            vaccine!,
                                            doseNumbers[i],
                                            statusInfo!,
                                          )
                                      : (statusInfo?.status ==
                                                  DoseStatus.completed &&
                                              onScheduledDoseTap != null)
                                          ? () => onScheduledDoseTap!(
                                                context,
                                                vaccine!,
                                                doseNumbers[i],
                                                statusInfo!,
                                              )
                                          : null,
                            ),
                            if (dateYearLabel != null &&
                                dateDateLabel != null) ...[
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 88,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      dateYearLabel,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      dateDateLabel,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (doseCount > 0 && recommendationText != null)
          DoseRecommendationBubble(
            text: recommendationText!,
            alignmentX: pointerAlignmentX.clamp(-1.0, 1.0),
          ),
      ],
    );
  }
}

class DoseRecommendationBubble extends StatelessWidget {
  const DoseRecommendationBubble({
    super.key,
    required this.text,
    required this.alignmentX,
  });

  final String text;
  final double alignmentX;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color backgroundColor = Colors.orange.shade50;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  offset: Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Align(
            alignment: Alignment(alignmentX, -1),
            child: SizedBox(
              width: 18,
              height: 10,
              child: CustomPaint(
                painter: _BubblePointerPainter(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubblePointerPainter extends CustomPainter {
  const _BubblePointerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
