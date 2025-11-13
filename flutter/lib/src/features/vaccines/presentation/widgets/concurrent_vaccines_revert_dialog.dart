import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';

import '../viewmodels/concurrent_vaccines_view_model.dart';

Future<bool?> showConcurrentVaccinesRevertDialog({
  required BuildContext context,
  required String householdId,
  required String childId,
  required String reservationGroupId,
  required String currentVaccineId,
  required String currentDoseId,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => _ConcurrentVaccinesRevertDialog(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      currentVaccineId: currentVaccineId,
      currentDoseId: currentDoseId,
    ),
  );
}

class _ConcurrentVaccinesRevertDialog extends ConsumerWidget {
  const _ConcurrentVaccinesRevertDialog({
    required this.householdId,
    required this.childId,
    required this.reservationGroupId,
    required this.currentVaccineId,
    required this.currentDoseId,
  });

  final String householdId;
  final String childId;
  final String reservationGroupId;
  final String currentVaccineId;
  final String currentDoseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(
      concurrentVaccinesViewModelProvider(
        ConcurrentVaccinesParams(
          householdId: householdId,
          childId: childId,
          reservationGroupId: reservationGroupId,
          currentVaccineId: currentVaccineId,
          currentDoseId: currentDoseId,
        ),
      ),
    );

    Widget buildMembersSection() {
      if (state.isLoading) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      }

      if (state.error != null) {
        return Text(
          state.error!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.red,
          ),
        );
      }

      if (state.members.isEmpty) {
        return Text(
          '他の同時接種ワクチンはありません',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        );
      }

      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final member = state.members[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.vaccines,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.vaccineName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${member.doseNumber}回目',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: state.members.length,
        ),
      );
    }

    Widget buildActionButton({
      required Widget child,
      required VoidCallback onPressed,
      required ButtonStyle? style,
    }) {
      return SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          style: style,
          child: child,
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '同時に予約したワクチンがあります。まとめて未接種に戻しますか？',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '同時接種のワクチン一覧',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            buildMembersSection(),
            const SizedBox(height: 24),
            buildActionButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '全て未接種に戻す',
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            buildActionButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'これだけ未接種に戻す',
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 8),
            buildActionButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'キャンセル',
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
