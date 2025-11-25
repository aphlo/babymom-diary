import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/usecases/get_reservation_group.dart';
import '../../application/usecases/get_vaccine_by_id.dart';
import '../../domain/entities/reservation_group.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../../application/vaccine_catalog_providers.dart';
import 'concurrent_vaccines_state.dart';

export 'concurrent_vaccines_state.dart';

class ConcurrentVaccinesViewModel
    extends StateNotifier<ConcurrentVaccinesState> {
  ConcurrentVaccinesViewModel({
    required GetReservationGroup getReservationGroup,
    required GetVaccineById getVaccineById,
    required VaccinationRecordRepository vaccinationRecordRepository,
  })  : _getReservationGroup = getReservationGroup,
        _getVaccineById = getVaccineById,
        _vaccinationRecordRepository = vaccinationRecordRepository,
        super(const ConcurrentVaccinesState());

  final GetReservationGroup _getReservationGroup;
  final GetVaccineById _getVaccineById;
  final VaccinationRecordRepository _vaccinationRecordRepository;

  Future<void> load({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String currentVaccineId,
    required String currentDoseId,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final group = await _getReservationGroup(
        householdId: householdId,
        childId: childId,
        reservationGroupId: reservationGroupId,
      );

      if (group == null) {
        if (!mounted) return;
        state = state.copyWith(isLoading: false, members: const []);
        return;
      }

      final otherMembers = group.members.where(
        (ReservationGroupMember member) =>
            member.vaccineId != currentVaccineId ||
            member.doseId != currentDoseId,
      );

      if (otherMembers.isEmpty) {
        if (!mounted) return;
        state = state.copyWith(isLoading: false, members: const []);
        return;
      }

      final resolvedMembers = <ConcurrentVaccineMember>[];
      for (final member in otherMembers) {
        final vaccine = await _getVaccineById(member.vaccineId);
        final displayName = vaccine?.name ?? member.vaccineId;

        // VaccinationRecordを取得してdoseNumberを確認
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: householdId,
          childId: childId,
          vaccineId: member.vaccineId,
        );

        // doseIdから実際のdoseNumberを取得
        int doseNumber = 1; // デフォルト値
        if (record != null) {
          final orderedDoses = record.orderedDoses;
          final doseIndex = orderedDoses.indexWhere(
            (dose) => dose.doseId == member.doseId,
          );
          if (doseIndex != -1) {
            doseNumber = doseIndex + 1; // 1-based indexing
          }
        }

        resolvedMembers.add(ConcurrentVaccineMember(
          vaccineId: member.vaccineId,
          vaccineName: displayName,
          doseId: member.doseId,
          doseNumber: doseNumber,
        ));
      }

      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        members: List<ConcurrentVaccineMember>.unmodifiable(resolvedMembers),
      );
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: '同時接種情報の取得に失敗しました',
      );
    }
  }
}

final concurrentVaccinesViewModelProvider = StateNotifierProvider.autoDispose
    .family<ConcurrentVaccinesViewModel, ConcurrentVaccinesState,
        ConcurrentVaccinesParams>(
  (ref, params) {
    final getReservationGroup = ref.watch(getReservationGroupProvider);
    final getVaccineById = ref.watch(getVaccineByIdProvider);
    final vaccinationRecordRepository =
        ref.watch(vaccinationRecordRepositoryProvider);
    final viewModel = ConcurrentVaccinesViewModel(
      getReservationGroup: getReservationGroup,
      getVaccineById: getVaccineById,
      vaccinationRecordRepository: vaccinationRecordRepository,
    );
    viewModel.load(
      householdId: params.householdId,
      childId: params.childId,
      reservationGroupId: params.reservationGroupId,
      currentVaccineId: params.currentVaccineId,
      currentDoseId: params.currentDoseId,
    );
    return viewModel;
  },
);
