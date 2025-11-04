import 'package:flutter/material.dart';

import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/concurrent_vaccines_confirmation_dialog.dart';

class VaccineDetailInteractions {
  const VaccineDetailInteractions({
    required this.viewModel,
    required this.detailState,
    required this.householdId,
    required this.childId,
  });

  final VaccineDetailViewModel viewModel;
  final VaccineDetailState detailState;
  final String householdId;
  final String childId;

  Future<void> markDoseAsCompleted(
    BuildContext context,
    VaccineInfo vaccine,
    int doseNumber,
  ) async {
    final groupId = detailState.doseStatuses[doseNumber]?.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      final bool? userSelection =
          await showConcurrentVaccinesConfirmationDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseNumber: doseNumber,
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
