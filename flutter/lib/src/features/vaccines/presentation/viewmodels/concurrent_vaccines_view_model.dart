import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import '../../application/usecases/get_reservation_group.dart';
import '../../application/usecases/get_vaccine_by_id.dart';
import '../../domain/entities/reservation_group.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../../application/vaccine_catalog_providers.dart';

@immutable
class ConcurrentVaccineMember {
  const ConcurrentVaccineMember({
    required this.vaccineId,
    required this.vaccineName,
    required this.doseId,
    required this.doseNumber,
  });

  final String vaccineId;
  final String vaccineName;
  final String doseId;
  final int doseNumber; // UI表示用
}

@immutable
class ConcurrentVaccinesState {
  const ConcurrentVaccinesState({
    this.isLoading = false,
    this.error,
    this.members = const <ConcurrentVaccineMember>[],
  });

  final bool isLoading;
  final String? error;
  final List<ConcurrentVaccineMember> members;

  ConcurrentVaccinesState copyWith({
    bool? isLoading,
    String? error,
    List<ConcurrentVaccineMember>? members,
    bool clearError = false,
  }) {
    return ConcurrentVaccinesState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      members: members ?? this.members,
    );
  }
}

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

      final resolvedMembers = await Future.wait(
        otherMembers.map((member) async {
          final vaccine = await _getVaccineById(member.vaccineId);
          final displayName = vaccine?.name ?? member.vaccineId;

          // VaccinationRecordを取得してdoseNumberを計算
          final record =
              await _vaccinationRecordRepository.getVaccinationRecord(
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

          return ConcurrentVaccineMember(
            vaccineId: member.vaccineId,
            vaccineName: displayName,
            doseId: member.doseId,
            doseNumber: doseNumber,
          );
        }),
      );

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

@immutable
class ConcurrentVaccinesParams {
  const ConcurrentVaccinesParams({
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcurrentVaccinesParams &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId &&
          childId == other.childId &&
          reservationGroupId == other.reservationGroupId &&
          currentVaccineId == other.currentVaccineId &&
          currentDoseId == other.currentDoseId;

  @override
  int get hashCode => Object.hash(
        householdId,
        childId,
        reservationGroupId,
        currentVaccineId,
        currentDoseId,
      );
}
