import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../children/application/selected_child_provider.dart';
import '../../../children/application/children_stream_provider.dart';
import '../../../children/domain/entities/child_summary.dart';
import '../../application/usecases/create_vaccine_reservation.dart';
import '../../application/usecases/get_vaccines_for_simulataneous_reservation.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../../domain/value_objects/vaccine_record_type.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';
import '../models/vaccine_info.dart';
import 'vaccine_reservation_state.dart';

// HouseholdServiceのプロバイダー
final householdServiceProvider = Provider<HouseholdService>((ref) {
  return HouseholdService(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );
});

class VaccineReservationViewModel
    extends StateNotifier<VaccineReservationState> {
  VaccineReservationViewModel({
    required CreateVaccineReservation createVaccineReservation,
    required GetVaccinesForSimultaneousReservation getAvailableVaccines,
    required HouseholdService householdService,
  })  : _createVaccineReservation = createVaccineReservation,
        _getAvailableVaccines = getAvailableVaccines,
        _householdService = householdService,
        super(const VaccineReservationState());

  final CreateVaccineReservation _createVaccineReservation;
  final GetVaccinesForSimultaneousReservation _getAvailableVaccines;
  final HouseholdService _householdService;

  /// 初期化
  Future<void> initialize({
    required VaccineInfo primaryVaccine,
    required int doseNumber,
    required String childId,
    required ChildSummary child,
  }) async {
    state = state.copyWith(
      isLoading: true,
      primaryVaccine: primaryVaccine,
      primaryDoseNumber: doseNumber,
    );

    try {
      final householdId =
          await _householdService.findExistingHouseholdForCurrentUser();
      if (householdId == null) {
        if (!mounted) return;
        state = state.copyWith(
          isLoading: false,
          error: 'ホームが見つかりません',
        );
        return;
      }

      // 年齢に基づいて同時接種可能なワクチンを取得
      final availableVaccines = await _getAvailableVaccines(
        householdId: householdId,
        childId: childId,
        child: child,
      );

      // メインのワクチンを除外
      final filteredVaccines = availableVaccines
          .where((vaccine) => vaccine.vaccineId != primaryVaccine.id)
          .toList();

      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        availableVaccines: filteredVaccines,
      );
    } catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: 'データの取得に失敗しました: $error',
      );
    }
  }

  /// 予約日時を設定
  void setScheduledDate(DateTime date) {
    state = state.copyWith(scheduledDate: date);
  }

  /// 記録種別を設定
  void setRecordType(VaccineRecordType recordType) {
    state = state.copyWith(recordType: recordType);
  }

  /// アコーディオンの開閉状態を切り替え
  void toggleAccordion() {
    state = state.copyWith(isAccordionExpanded: !state.isAccordionExpanded);
  }

  /// 同時接種ワクチンを選択/選択解除
  void toggleAdditionalVaccine(String vaccineId) {
    final currentSelected = List.of(state.selectedAdditionalVaccines);
    final vaccine =
        state.availableVaccines.firstWhere((v) => v.vaccineId == vaccineId);

    final isSelected = currentSelected.any((v) => v.vaccineId == vaccineId);

    if (isSelected) {
      currentSelected.removeWhere((v) => v.vaccineId == vaccineId);
    } else {
      currentSelected.add(vaccine);
    }

    state = state.copyWith(selectedAdditionalVaccines: currentSelected);
  }

  /// 予約を作成
  Future<bool> createReservation(String childId) async {
    if (!state.canSubmit) return false;

    state = state.copyWith(isSubmitting: true, error: null);

    try {
      final householdId =
          await _householdService.findExistingHouseholdForCurrentUser();
      if (householdId == null) {
        if (!mounted) return false;
        state = state.copyWith(
          isSubmitting: false,
          error: 'ホームが見つかりません',
        );
        return false;
      }

      final requests = state.generateReservationRequests(childId);

      if (requests.isEmpty) {
        if (!mounted) return false;
        state = state.copyWith(
          isSubmitting: false,
          error: '予約情報が不正です',
        );
        return false;
      }

      if (requests.length == 1) {
        // 単一のワクチン予約
        await _createVaccineReservation(
          householdId: householdId,
          request: requests.first,
        );
      } else {
        // 複数のワクチン予約（同時接種）
        await _createVaccineReservation.createMultiple(
          householdId: householdId,
          childId: childId,
          scheduledDate: state.scheduledDate!,
          requests: requests,
        );
      }

      if (!mounted) return false;
      state = state.copyWith(isSubmitting: false);
      return true;
    } on DuplicateScheduleDateException catch (e) {
      if (!mounted) return false;
      state = state.copyWith(
        isSubmitting: false,
        error: e.message,
        isDuplicateError: true,
      );
      return false;
    } catch (error) {
      if (!mounted) return false;
      state = state.copyWith(
        isSubmitting: false,
        error: '予約の作成に失敗しました: $error',
      );
      return false;
    }
  }

  /// エラーをクリア
  void clearError() {
    state = state.clearError();
  }
}

// Provider
final vaccineReservationViewModelProvider = StateNotifierProvider.autoDispose
    .family<VaccineReservationViewModel, VaccineReservationState,
        VaccineReservationParams>(
  (ref, params) {
    final createVaccineReservation =
        ref.watch(createVaccineReservationProvider);
    final getAvailableVaccines =
        ref.watch(getAvailableVaccinesForSimultaneousReservationProvider);
    final householdService = ref.watch(householdServiceProvider);

    final viewModel = VaccineReservationViewModel(
      createVaccineReservation: createVaccineReservation,
      getAvailableVaccines: getAvailableVaccines,
      householdService: householdService,
    );

    // 初期化

    final selectedChildId = ref.watch(selectedChildControllerProvider).value;

    if (selectedChildId != null) {
      // まずhouseholdIdを取得
      Future.microtask(() async {
        try {
          final householdId =
              await householdService.findExistingHouseholdForCurrentUser();
          if (householdId != null) {
            // 子供のリストから該当する子供を検索
            final childrenAsync =
                ref.watch(childrenStreamProvider(householdId));

            childrenAsync.when(
              data: (children) {
                final selectedChild = children
                        .where((child) => child.id == selectedChildId)
                        .isNotEmpty
                    ? children
                        .firstWhere((child) => child.id == selectedChildId)
                    : null;

                if (selectedChild != null) {
                  viewModel.initialize(
                    primaryVaccine: params.vaccine,
                    doseNumber: params.doseNumber,
                    childId: selectedChildId,
                    child: selectedChild,
                  );
                } else {}
              },
              loading: () {},
              error: (error, stackTrace) {},
            );
          } else {}
        } catch (error) {/* Intentionally ignored */}
      });
    } else {}

    return viewModel;
  },
);

// Parameters class
class VaccineReservationParams {
  const VaccineReservationParams({
    required this.vaccine,
    required this.doseNumber,
  });

  final VaccineInfo vaccine;
  final int doseNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineReservationParams &&
          runtimeType == other.runtimeType &&
          vaccine == other.vaccine &&
          doseNumber == other.doseNumber;

  @override
  int get hashCode => vaccine.hashCode ^ doseNumber.hashCode;
}
