import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/concurrent_vaccines_view_model.dart';

/// doseIdを取得するためのパラメータ
@immutable
class _DoseIdParams {
  const _DoseIdParams({
    required this.householdId,
    required this.childId,
    required this.vaccineId,
    required this.doseNumber,
  });

  final String householdId;
  final String childId;
  final String vaccineId;
  final int doseNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _DoseIdParams &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId &&
          childId == other.childId &&
          vaccineId == other.vaccineId &&
          doseNumber == other.doseNumber;

  @override
  int get hashCode => Object.hash(
        householdId,
        childId,
        vaccineId,
        doseNumber,
      );
}

/// doseIdを取得するProvider
final _doseIdProvider =
    FutureProvider.autoDispose.family<String?, _DoseIdParams>(
  (ref, params) async {
    final repository = ref.watch(vaccinationRecordRepositoryProvider);
    final record = await repository.getVaccinationRecord(
      householdId: params.householdId,
      childId: params.childId,
      vaccineId: params.vaccineId,
    );
    final doseRecord = record?.getDoseByNumber(params.doseNumber);
    return doseRecord?.doseId;
  },
);

/// 同時接種するワクチンを表示する共通カードウィジェット
///
/// [vaccine] - 現在表示しているワクチン
/// [doseNumber] - 現在表示しているdoseNumber
/// [reservationGroupId] - 予約グループID（nullの場合は「同時接種なし」を表示）
class ConcurrentVaccinesCard extends ConsumerWidget {
  const ConcurrentVaccinesCard({
    super.key,
    required this.vaccine,
    required this.doseNumber,
    this.reservationGroupId,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final String? reservationGroupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final householdId = ref.watch(currentHouseholdIdProvider).value;
    final childId = ref.watch(selectedChildControllerProvider).value;

    // 予約グループIDがない、またはhouseholdId/childIdがない場合
    if (reservationGroupId == null ||
        reservationGroupId!.isEmpty ||
        householdId == null ||
        childId == null) {
      return _buildCard(theme, _buildEmptyContent(theme));
    }

    // doseIdを取得
    final doseIdParams = _DoseIdParams(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccine.id,
      doseNumber: doseNumber,
    );
    final doseIdAsync = ref.watch(_doseIdProvider(doseIdParams));

    return doseIdAsync.when(
      loading: () => _buildCard(
        theme,
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (_, __) => _buildCard(theme, _buildEmptyContent(theme)),
      data: (doseId) {
        if (doseId == null) {
          return _buildCard(theme, _buildEmptyContent(theme));
        }

        // ConcurrentVaccinesViewModelを使用して同時接種ワクチンを取得
        final params = ConcurrentVaccinesParams(
          householdId: householdId,
          childId: childId,
          reservationGroupId: reservationGroupId!,
          currentVaccineId: vaccine.id,
          currentDoseId: doseId,
        );

        final state = ref.watch(concurrentVaccinesViewModelProvider(params));

        Widget content;

        if (state.isLoading) {
          content = const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.error != null) {
          content = Text(
            state.error!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.red,
            ),
          );
        } else if (state.members.isEmpty) {
          content = _buildEmptyContent(theme);
        } else {
          content = _buildMembersList(theme, state.members);
        }

        return _buildCard(theme, content);
      },
    );
  }

  Widget _buildCard(ThemeData theme, Widget content) {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.vaccines,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                '同時接種するワクチン',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildEmptyContent(ThemeData theme) {
    return Text(
      '同時接種するワクチンはありません',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildMembersList(
    ThemeData theme,
    List<ConcurrentVaccineMember> members,
  ) {
    return Column(
      children: [
        for (var i = 0; i < members.length; i++)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: i == members.length - 1 ? 0 : 12,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.vaccines,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    members[i].vaccineName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${members[i].doseNumber}回目',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
