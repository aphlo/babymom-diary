import 'package:flutter/material.dart';

import '../../application/vaccine_catalog_providers.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/concurrent_vaccines_confirmation_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    bool applyToGroup = true;

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
