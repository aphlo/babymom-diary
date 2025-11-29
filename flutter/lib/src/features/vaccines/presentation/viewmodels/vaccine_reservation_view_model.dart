import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../menu/children/application/child_context_provider.dart';
import '../../application/usecases/create_vaccine_reservation.dart';
import '../../application/usecases/get_vaccines_for_simulataneous_reservation.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../../domain/value_objects/vaccine_record_type.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';
import 'vaccine_reservation_state.dart';

export 'vaccine_reservation_state.dart';

part 'vaccine_reservation_view_model.g.dart';

@riverpod
class VaccineReservationViewModel extends _$VaccineReservationViewModel {
  CreateVaccineReservation get _createVaccineReservation =>
      ref.read(createVaccineReservationProvider);
  GetVaccinesForSimultaneousReservation get _getAvailableVaccines =>
      ref.read(getAvailableVaccinesForSimultaneousReservationProvider);

  @override
  VaccineReservationState build(VaccineReservationParams params) {
    // 初期化処理をスケジュール
    Future.microtask(() => _initialize(params));

    return VaccineReservationState(
      primaryVaccine: params.vaccine,
      primaryDoseNumber: params.doseNumber,
      isLoading: true,
    );
  }

  Future<void> _initialize(VaccineReservationParams params) async {
    final childContext = ref.read(childContextProvider).value;
    if (childContext == null) {
      state = state.copyWith(
        isLoading: false,
        error: '子どもが選択されていません',
      );
      return;
    }

    final selectedChildId = childContext.selectedChildId;
    final selectedChild = childContext.selectedChildSummary;

    if (selectedChildId == null || selectedChild == null) {
      state = state.copyWith(
        isLoading: false,
        error: '子どもが選択されていません',
      );
      return;
    }

    try {
      final householdId = childContext.householdId;

      // 年齢に基づいて同時接種可能なワクチンを取得
      final availableVaccines = await _getAvailableVaccines(
        householdId: householdId,
        childId: selectedChildId,
        child: selectedChild,
      );

      // メインのワクチンを除外
      final filteredVaccines = availableVaccines
          .where((vaccine) => vaccine.vaccineId != params.vaccine.id)
          .toList();

      state = state.copyWith(
        isLoading: false,
        availableVaccines: filteredVaccines,
      );
    } catch (error) {
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
  Future<bool> createReservation() async {
    if (!state.canSubmit) return false;

    final childContext = ref.read(childContextProvider).value;
    if (childContext == null) {
      state = state.copyWith(
        isSubmitting: false,
        error: '子どもが選択されていません',
      );
      return false;
    }

    final childId = childContext.selectedChildId;
    if (childId == null) {
      state = state.copyWith(
        isSubmitting: false,
        error: '子どもが選択されていません',
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true, error: null);

    try {
      final householdId = childContext.householdId;
      final requests = state.generateReservationRequests(childId);

      if (requests.isEmpty) {
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

      state = state.copyWith(isSubmitting: false);
      return true;
    } on DuplicateScheduleDateException catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: e.message,
        isDuplicateError: true,
      );
      return false;
    } catch (error) {
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
