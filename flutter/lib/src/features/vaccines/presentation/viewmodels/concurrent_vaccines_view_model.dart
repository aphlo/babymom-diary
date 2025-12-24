import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/usecases/get_reservation_group.dart';
import '../../application/usecases/get_vaccine_by_id.dart';
import '../../domain/entities/reservation_group.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../../application/vaccine_catalog_providers.dart';
import 'concurrent_vaccines_state.dart';

export 'concurrent_vaccines_state.dart';

part 'concurrent_vaccines_view_model.g.dart';

@riverpod
class ConcurrentVaccinesViewModel extends _$ConcurrentVaccinesViewModel {
  GetReservationGroup get _getReservationGroup =>
      ref.read(getReservationGroupProvider);
  GetVaccineById get _getVaccineById => ref.read(getVaccineByIdProvider);
  VaccinationRecordRepository get _vaccinationRecordRepository =>
      ref.read(vaccinationRecordRepositoryProvider);

  @override
  ConcurrentVaccinesState build(ConcurrentVaccinesParams params) {
    // 初期化処理をスケジュール
    Future.microtask(() => _load(params));

    return const ConcurrentVaccinesState(isLoading: true);
  }

  Future<void> _load(ConcurrentVaccinesParams params) async {
    try {
      final group = await _getReservationGroup(
        householdId: params.householdId,
        childId: params.childId,
        reservationGroupId: params.reservationGroupId,
      );

      if (group == null) {
        state = state.copyWith(
          isLoading: false,
          members: const [],
          error: null,
        );
        return;
      }

      final otherMembers = group.members.where(
        (ReservationGroupMember member) =>
            member.vaccineId != params.currentVaccineId ||
            member.doseId != params.currentDoseId,
      );

      if (otherMembers.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          members: const [],
          error: null,
        );
        return;
      }

      final resolvedMembers = <ConcurrentVaccineMember>[];
      for (final member in otherMembers) {
        final vaccine = await _getVaccineById(member.vaccineId);
        final displayName = vaccine?.name ?? member.vaccineId;

        // VaccinationRecordを取得してdoseNumberを確認
        final record = await _vaccinationRecordRepository.getVaccinationRecord(
          householdId: params.householdId,
          childId: params.childId,
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

      state = state.copyWith(
        isLoading: false,
        members: List<ConcurrentVaccineMember>.unmodifiable(resolvedMembers),
        error: null,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: '同時接種情報の取得に失敗しました',
      );
    }
  }
}
