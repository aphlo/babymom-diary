import 'package:meta/meta.dart';

import '../../domain/entities/dose_record.dart';

@immutable
class DoseStatusInfo {
  const DoseStatusInfo({
    required this.doseNumber,
    this.status,
    this.scheduledDate,
    this.completedDate,
  });

  final int doseNumber;
  final DoseStatus? status;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
}

@immutable
class VaccineDetailState {
  const VaccineDetailState({
    this.isLoading = false,
    this.error,
    this.doseStatuses = const <int, DoseStatusInfo>{},
    this.activeDoseNumber,
  });

  final bool isLoading;
  final String? error;
  final Map<int, DoseStatusInfo> doseStatuses;
  final int? activeDoseNumber;

  VaccineDetailState copyWith({
    bool? isLoading,
    String? error,
    Map<int, DoseStatusInfo>? doseStatuses,
    int? activeDoseNumber,
    bool clearError = false,
  }) {
    return VaccineDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      doseStatuses: doseStatuses ?? this.doseStatuses,
      activeDoseNumber: activeDoseNumber ?? this.activeDoseNumber,
    );
  }
}
