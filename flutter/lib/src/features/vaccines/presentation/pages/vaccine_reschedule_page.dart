import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_card.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_reschedule_dialog.dart';
import '../widgets/reservation/date_selection_card.dart';
import '../widgets/shared/vaccine_error_dialog.dart';
import '../widgets/shared/vaccine_info_card.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';

class VaccineReschedulePage extends ConsumerStatefulWidget {
  const VaccineReschedulePage({
    super.key,
    required this.vaccine,
    required this.doseNumber,
    required this.statusInfo,
    this.influenzaSeasonLabel,
    this.influenzaDoseOrder,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final DoseStatusInfo statusInfo;
  final String? influenzaSeasonLabel;
  final int? influenzaDoseOrder;

  @override
  ConsumerState<VaccineReschedulePage> createState() =>
      _VaccineReschedulePageState();
}

class _VaccineReschedulePageState extends ConsumerState<VaccineReschedulePage> {
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.statusInfo.scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    final bool canSubmit = _selectedDate != null && !_isLoading;

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: const Text('日付を変更'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VaccineInfoCard(
                    vaccine: widget.vaccine,
                    doseNumber: widget.doseNumber,
                    influenzaSeasonLabel: widget.influenzaSeasonLabel,
                    influenzaDoseOrder: widget.influenzaDoseOrder,
                  ),
                  const SizedBox(height: 24),
                  DateSelectionCard(
                    title: '新しい日付',
                    selectedDate: _selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ConcurrentVaccinesCard(
                    vaccine: widget.vaccine,
                    doseNumber: widget.doseNumber,
                    reservationGroupId: widget.statusInfo.reservationGroupId,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: canSubmit ? () => _updateSchedule(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('日付を変更'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateSchedule(BuildContext context) async {
    if (_selectedDate == null) return;

    final householdId = ref.read(currentHouseholdIdProvider).value;
    final childId = ref.read(selectedChildControllerProvider).value;

    if (householdId == null || childId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('必要な情報が不足しています'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final groupId = widget.statusInfo.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      final repository = ref.read(vaccinationRecordRepositoryProvider);
      final record = await repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: widget.vaccine.id,
      );
      final doseRecord = record?.getDoseByNumber(widget.doseNumber);

      if (doseRecord == null) {
        if (mounted && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('接種記録が見つかりません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      if (!mounted || !context.mounted) return;

      final bool? userSelection = await showConcurrentVaccinesRescheduleDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: widget.vaccine.id,
        currentDoseId: doseRecord.doseId,
      );

      if (userSelection == null) {
        return;
      }
      applyToGroup = userSelection;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final params = VaccineDetailParams(
        vaccineId: widget.vaccine.id,
        doseNumbers: [widget.doseNumber],
        householdId: householdId,
        childId: childId,
        childBirthday: null,
      );

      final viewModel =
          ref.read(vaccineDetailViewModelProvider(params).notifier);
      await viewModel.updateVaccineReservation(
        doseNumber: widget.doseNumber,
        scheduledDate: _selectedDate!,
        applyToGroup: applyToGroup,
        reservationGroupId: widget.statusInfo.reservationGroupId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('日付を変更しました')),
        );
        context.pop();
      }
    } on DuplicateScheduleDateException catch (e) {
      if (context.mounted) {
        await VaccineErrorDialog.show(
          context: context,
          title: '予約を変更できません',
          message: e.message,
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('日付変更に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
