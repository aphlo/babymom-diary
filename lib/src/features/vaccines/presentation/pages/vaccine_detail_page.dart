import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../../../children/application/selected_child_provider.dart';
import '../../domain/entities/dose_record.dart';
import '../models/vaccine_info.dart';
import '../utils/vaccination_period_calculator.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/vaccine_header.dart';

class VaccineDetailPage extends ConsumerWidget {
  const VaccineDetailPage({
    super.key,
    required this.vaccine,
    this.childBirthday,
  });

  final VaccineInfo vaccine;
  final DateTime? childBirthday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<int, List<String>> dosePeriodMap = _extractDosePeriods(vaccine);
    final List<int> doseNumbers = dosePeriodMap.keys.toList()..sort();

    final AsyncValue<String> householdAsync =
        ref.watch(currentHouseholdIdProvider);
    final AsyncValue<String?> selectedChildAsync =
        ref.watch(selectedChildControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(vaccine.name)),
      body: householdAsync.when(
        data: (householdId) {
          return selectedChildAsync.when(
            data: (childId) {
              if (childId == null) {
                return const _NoChildSelectedView();
              }

              final params = VaccineDetailParams(
                vaccineId: vaccine.id,
                doseNumbers: List<int>.unmodifiable(doseNumbers),
                householdId: householdId,
                childId: childId,
              );

              final VaccineDetailState detailState =
                  ref.watch(vaccineDetailViewModelProvider(params));

              return _VaccineDetailContent(
                vaccine: vaccine,
                childBirthday: childBirthday,
                doseNumbers: doseNumbers,
                dosePeriodMap: dosePeriodMap,
                state: detailState,
                onReservationTap: _navigateToReservation,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const _AsyncErrorView(message: '子供情報の取得に失敗しました'),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const _AsyncErrorView(message: 'ホーム情報の取得に失敗しました'),
      ),
    );
  }

  Map<int, List<String>> _extractDosePeriods(VaccineInfo vaccine) {
    final Map<int, List<String>> result = <int, List<String>>{};
    vaccine.doseSchedules.forEach((String periodLabel, List<int> doses) {
      for (final int dose in doses) {
        final periods = result.putIfAbsent(dose, () => <String>[]);
        if (!periods.contains(periodLabel)) {
          periods.add(periodLabel);
        }
      }
    });
    return result;
  }

  void _navigateToReservation(
      BuildContext context, VaccineInfo vaccine, int doseNumber) {
    context.push('/vaccines/reservation', extra: {
      'vaccine': vaccine,
      'doseNumber': doseNumber,
    });
  }
}

class _VaccineDetailContent extends StatelessWidget {
  const _VaccineDetailContent({
    required this.vaccine,
    required this.childBirthday,
    required this.doseNumbers,
    required this.dosePeriodMap,
    required this.state,
    required this.onReservationTap,
  });

  final VaccineInfo vaccine;
  final DateTime? childBirthday;
  final List<int> doseNumbers;
  final Map<int, List<String>> dosePeriodMap;
  final VaccineDetailState state;
  final Function(BuildContext, VaccineInfo, int)? onReservationTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  offset: Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VaccineHeader(vaccine: vaccine),
                if (state.isLoading) ...[
                  const SizedBox(height: 16),
                  const LinearProgressIndicator(minHeight: 3),
                ],
                const SizedBox(height: 24),
                if (state.error != null) ...[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      state.error!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                if (doseNumbers.isEmpty)
                  Text(
                    '接種回数の情報が見つかりませんでした',
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  VaccineDoseReservationBoard(
                    doseNumbers: doseNumbers,
                    periodsByDose: dosePeriodMap,
                    doseStatuses: state.doseStatuses,
                    activeDoseNumber: state.activeDoseNumber,
                    childBirthday: childBirthday,
                    vaccine: vaccine,
                    onReservationTap: onReservationTap,
                  ),
                if (vaccine.notes.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '接種時の注意点',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _VaccineNotesList(notes: vaccine.notes),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VaccineDoseReservationBoard extends StatelessWidget {
  const VaccineDoseReservationBoard({
    super.key,
    required this.doseNumbers,
    required this.periodsByDose,
    required this.doseStatuses,
    this.activeDoseNumber,
    this.childBirthday,
    this.vaccine,
    this.onReservationTap,
  });

  final List<int> doseNumbers;
  final Map<int, List<String>> periodsByDose;
  final Map<int, DoseStatusInfo> doseStatuses;
  final int? activeDoseNumber;
  final DateTime? childBirthday;
  final VaccineInfo? vaccine;
  final Function(BuildContext context, VaccineInfo vaccine, int doseNumber)?
      onReservationTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final int doseCount = doseNumbers.length;

    final int? resolvedActiveDose =
        (activeDoseNumber != null && doseNumbers.contains(activeDoseNumber))
            ? activeDoseNumber
            : (doseCount > 0 ? doseNumbers.first : null);
    final int normalizedActiveIndex = doseCount == 0
        ? 0
        : doseNumbers
            .indexOf(resolvedActiveDose ?? doseNumbers.first)
            .clamp(0, doseCount - 1);
    final double pointerAlignmentX = doseCount == 0
        ? 0
        : ((normalizedActiveIndex + 0.5) / doseCount) * 2 - 1;

    final List<String> activeLabels = doseCount == 0
        ? const <String>[]
        : periodsByDose[doseNumbers[normalizedActiveIndex]] ?? const <String>[];
    final DoseStatusInfo? activeStatus = doseCount == 0
        ? null
        : doseStatuses[doseNumbers[normalizedActiveIndex]];
    final String recommendationText = _buildRecommendationText(
      labels: activeLabels,
      childBirthday: childBirthday,
      activeStatus: activeStatus,
    );

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
                            _DoseBadgePresentation.fromStatus(statusInfo);
                        final bool isActive = i == normalizedActiveIndex;
                        final bool canTap = isActive &&
                            vaccine != null &&
                            onReservationTap != null &&
                            statusInfo?.status != DoseStatus.completed;
                        return _DoseStatusBadge(
                          presentation: presentation,
                          isActive: isActive,
                          onTap: canTap
                              ? () => onReservationTap!(
                                  context, vaccine!, doseNumbers[i])
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (doseCount > 0)
          _DoseRecommendationBubble(
            text: recommendationText,
            alignmentX: pointerAlignmentX.clamp(-1.0, 1.0),
          ),
      ],
    );
  }
}

String _buildRecommendationText({
  required List<String> labels,
  required DateTime? childBirthday,
  DoseStatusInfo? activeStatus,
}) {
  final DoseStatus? status = activeStatus?.status;

  if (status == DoseStatus.scheduled && activeStatus?.scheduledDate != null) {
    final String scheduledText =
        DateFormatter.yyyyMMddE(activeStatus!.scheduledDate!);
    return '接種予約日\n$scheduledText';
  }

  if (status == DoseStatus.completed && activeStatus?.completedDate != null) {
    final String completedText =
        DateFormatter.yyyyMMddE(activeStatus!.completedDate!);
    return '接種完了日\n$completedText';
  }

  if (status == DoseStatus.skipped) {
    return '接種を見送りました';
  }

  if (labels.isEmpty) {
    return '接種時期の情報がありません';
  }

  final DateRange? range = VaccinationPeriodCalculator.dateRangeForLabels(
    birthday: childBirthday,
    labels: labels,
  );
  if (range == null || range.end.isBefore(range.start)) {
    return _fallbackRecommendationText(labels);
  }

  final String startText = DateFormatter.yyyyMMddE(range.start);
  final String endText = DateFormatter.yyyyMMddE(range.end);

  if (range.start.isAtSameMomentAs(range.end)) {
    return '接種時期のめやす\n$startText';
  }
  return '接種時期のめやす\n$startText〜\n$endText';
}

String _fallbackRecommendationText(List<String> labels) {
  if (labels.length == 1) {
    return '接種時期のめやす\n${labels.first}ごろ';
  }
  return '接種時期のめやす\n${labels.first} 〜 ${labels.last}ごろ';
}

class _VaccineNotesList extends StatelessWidget {
  const _VaccineNotesList({required this.notes});

  final List<VaccineGuidelineNote> notes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: notes.asMap().entries.map((entry) {
        final note = entry.value;
        final TextStyle? textStyle = textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: Colors.black,
        );

        return Padding(
          padding: EdgeInsets.only(top: entry.key == 0 ? 0 : 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.circle,
                size: 6,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  note.message,
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(growable: false),
    );
  }
}

class _DoseBadgePresentation {
  const _DoseBadgePresentation({
    required this.label,
    required this.baseColor,
    required this.icon,
    required this.status,
  });

  final String label;
  final Color baseColor;
  final IconData icon;
  final DoseStatus? status;

  static _DoseBadgePresentation fromStatus(DoseStatusInfo? info) {
    switch (info?.status) {
      case DoseStatus.completed:
        return const _DoseBadgePresentation(
          label: '接種済',
          baseColor: Colors.green,
          icon: Icons.check_circle,
          status: DoseStatus.completed,
        );
      case DoseStatus.scheduled:
        return const _DoseBadgePresentation(
          label: '予約済',
          baseColor: AppColors.secondary,
          icon: Icons.event_available,
          status: DoseStatus.scheduled,
        );
      case DoseStatus.skipped:
        return const _DoseBadgePresentation(
          label: '見送り',
          baseColor: Colors.orange,
          icon: Icons.pause_circle,
          status: DoseStatus.skipped,
        );
      default:
        return const _DoseBadgePresentation(
          label: '未定',
          baseColor: Colors.grey,
          icon: Icons.vaccines,
          status: null,
        );
    }
  }
}

class _DoseStatusBadge extends StatelessWidget {
  const _DoseStatusBadge({
    required this.presentation,
    required this.isActive,
    this.onTap,
  });

  final _DoseBadgePresentation presentation;
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
        isActive ? effectiveColor : baseColor.withOpacity(0.6);
    final Color backgroundColor = isActive
        ? effectiveColor.withOpacity(0.15)
        : baseColor.withOpacity(0.08);
    final TextStyle textStyle = theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: borderColor,
        ) ??
        TextStyle(
            fontWeight: FontWeight.w700, color: borderColor, fontSize: 12);

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

class _DoseRecommendationBubble extends StatelessWidget {
  const _DoseRecommendationBubble({
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

class _NoChildSelectedView extends StatelessWidget {
  const _NoChildSelectedView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '子供を選択すると接種予定を確認できます',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _AsyncErrorView extends StatelessWidget {
  const _AsyncErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
