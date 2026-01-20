import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/vaccine_catalog_providers.dart';
import '../../domain/entities/dose_record.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_confirmation_dialog.dart';

class VaccineDetailInteractions {
  const VaccineDetailInteractions({
    required this.viewModel,
    required this.detailState,
    required this.householdId,
    required this.childId,
    required this.ref,
  });

  final VaccineDetailViewModel viewModel;
  final VaccineDetailState detailState;
  final String householdId;
  final String childId;
  final WidgetRef ref;

  Future<void> markDoseAsCompleted(
    BuildContext context,
    VaccineInfo vaccine,
    int doseNumber,
  ) async {
    final groupId = detailState.doseStatuses[doseNumber]?.reservationGroupId;
    // groupIdがnullの場合は単独ワクチンとして処理
    bool applyToGroup = groupId != null;

    if (groupId != null) {
      // doseIdを取得するためにVaccinationRecordを取得
      final repository = ref.read(vaccinationRecordRepositoryProvider);
      final record = await repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: vaccine.id,
      );
      final doseRecord = record?.getDoseByNumber(doseNumber);

      if (doseRecord == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('接種記録が見つかりません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // グループ内に他の予約済み（未接種）メンバーがいるかチェック
      final getReservationGroup = ref.read(getReservationGroupProvider);
      final group = await getReservationGroup(
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
      );

      // 他のメンバーで予約済み（未接種）のものがあるかチェック
      bool hasOtherScheduledMembers = false;
      if (group != null) {
        for (final member in group.members) {
          // 自分自身はスキップ
          if (member.vaccineId == vaccine.id &&
              member.doseId == doseRecord.doseId) {
            continue;
          }

          // 他のメンバーの接種状況を確認
          final memberRecord = await repository.getVaccinationRecord(
            householdId: householdId,
            childId: childId,
            vaccineId: member.vaccineId,
          );
          if (memberRecord != null) {
            final memberDoseIndex = memberRecord.orderedDoses.indexWhere(
              (dose) => dose.doseId == member.doseId,
            );
            if (memberDoseIndex != -1) {
              final memberDose = memberRecord.orderedDoses[memberDoseIndex];
              // 予約済み（scheduled）のメンバーがいればフラグを立てる
              if (memberDose.status == DoseStatus.scheduled) {
                hasOtherScheduledMembers = true;
                break;
              }
            }
          }
        }
      }

      if (hasOtherScheduledMembers) {
        // 他の予約済みメンバーがいる場合のみダイアログを表示
        if (!context.mounted) return;

        final bool? userSelection =
            await showConcurrentVaccinesConfirmationDialog(
          context: context,
          householdId: householdId,
          childId: childId,
          reservationGroupId: groupId,
          currentVaccineId: vaccine.id,
          currentDoseId: doseRecord.doseId,
        );

        if (userSelection == null) {
          return;
        }
        applyToGroup = userSelection;
      } else {
        // 他の予約済みメンバーがいない場合は単独処理
        applyToGroup = false;
      }
    }

    try {
      await viewModel.markDoseAsCompleted(
        doseNumber: doseNumber,
        applyToGroup: applyToGroup,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('接種済みに変更しました')),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('接種済みへの変更に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
