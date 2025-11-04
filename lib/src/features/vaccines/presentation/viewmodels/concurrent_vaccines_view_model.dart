import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import '../../application/usecases/get_reservation_group.dart';
import '../../application/usecases/get_vaccine_by_id.dart';
import '../../domain/entities/reservation_group.dart';
import '../../application/vaccine_catalog_providers.dart';

@immutable
class ConcurrentVaccineMember {
  const ConcurrentVaccineMember({
    required this.vaccineId,
    required this.vaccineName,
    required this.doseNumber,
  });

  final String vaccineId;
  final String vaccineName;
  final int doseNumber;
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
  })  : _getReservationGroup = getReservationGroup,
        _getVaccineById = getVaccineById,
        super(const ConcurrentVaccinesState());

  final GetReservationGroup _getReservationGroup;
  final GetVaccineById _getVaccineById;

  Future<void> load({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String currentVaccineId,
    required int currentDoseNumber,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final group = await _getReservationGroup(
        householdId: householdId,
        childId: childId,
        reservationGroupId: reservationGroupId,
      );

      if (group == null) {
        state = state.copyWith(isLoading: false, members: const []);
        return;
      }

      final otherMembers = group.members.where(
        (ReservationGroupMember member) =>
            member.vaccineId != currentVaccineId ||
            member.doseNumber != currentDoseNumber,
      );

      if (otherMembers.isEmpty) {
        state = state.copyWith(isLoading: false, members: const []);
        return;
      }

      final resolvedMembers = await Future.wait(
        otherMembers.map((member) async {
          final vaccine = await _getVaccineById(member.vaccineId);
          final displayName = vaccine?.name ?? member.vaccineId;
          return ConcurrentVaccineMember(
            vaccineId: member.vaccineId,
            vaccineName: displayName,
            doseNumber: member.doseNumber,
          );
        }),
      );

      state = state.copyWith(
        isLoading: false,
        members: List<ConcurrentVaccineMember>.unmodifiable(resolvedMembers),
      );
    } catch (_) {
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
    final viewModel = ConcurrentVaccinesViewModel(
      getReservationGroup: getReservationGroup,
      getVaccineById: getVaccineById,
    );
    viewModel.load(
      householdId: params.householdId,
      childId: params.childId,
      reservationGroupId: params.reservationGroupId,
      currentVaccineId: params.currentVaccineId,
      currentDoseNumber: params.currentDoseNumber,
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
    required this.currentDoseNumber,
  });

  final String householdId;
  final String childId;
  final String reservationGroupId;
  final String currentVaccineId;
  final int currentDoseNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcurrentVaccinesParams &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId &&
          childId == other.childId &&
          reservationGroupId == other.reservationGroupId &&
          currentVaccineId == other.currentVaccineId &&
          currentDoseNumber == other.currentDoseNumber;

  @override
  int get hashCode => Object.hash(
        householdId,
        childId,
        reservationGroupId,
        currentVaccineId,
        currentDoseNumber,
      );
}
