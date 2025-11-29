import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_master_repository.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccination_record_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/in_memory_vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/in_memory_vaccine_master_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/vaccination_record_repository_impl.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/sources/vaccination_record_firestore_data_source.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/create_vaccine_reservation.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_available_vaccines_for_reservation.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccines_for_simulataneous_reservation.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_by_id.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_reservation_group.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/watch_vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/watch_vaccination_records.dart';
import 'package:babymom_diary/src/features/vaccines/domain/services/vaccination_schedule_policy.dart';
import 'package:babymom_diary/src/features/vaccines/domain/services/vaccine_schedule_conflict_validator.dart';
import 'package:babymom_diary/src/features/menu/household/application/vaccine_visibility_settings_provider.dart';

part 'vaccine_catalog_providers.g.dart';

@Riverpod(keepAlive: true)
VaccineCatalogRepository vaccineCatalogRepository(Ref ref) {
  return const InMemoryVaccineCatalogRepository();
}

@Riverpod(keepAlive: true)
VaccineMasterRepository vaccineMasterRepository(Ref ref) {
  return const InMemoryVaccineMasterRepository();
}

@Riverpod(keepAlive: true)
VaccinationRecordFirestoreDataSource vaccinationRecordDataSource(Ref ref) {
  final vaccineMasterRepository = ref.watch(vaccineMasterRepositoryProvider);
  return VaccinationRecordFirestoreDataSource(
    FirebaseFirestore.instance,
    vaccineMasterRepository,
  );
}

@Riverpod(keepAlive: true)
VaccineScheduleConflictValidator vaccineScheduleConflictValidator(Ref ref) {
  return VaccineScheduleConflictValidator();
}

@Riverpod(keepAlive: true)
VaccinationRecordRepository vaccinationRecordRepository(Ref ref) {
  final dataSource = ref.watch(vaccinationRecordDataSourceProvider);
  final conflictValidator = ref.watch(vaccineScheduleConflictValidatorProvider);
  return VaccinationRecordRepositoryImpl(
    dataSource,
    conflictValidator,
  );
}

@Riverpod(keepAlive: true)
GetVaccineMaster getVaccineGuideline(Ref ref) {
  final repository = ref.watch(vaccineCatalogRepositoryProvider);
  return GetVaccineMaster(repository);
}

@Riverpod(keepAlive: true)
CreateVaccineReservation createVaccineReservation(Ref ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return CreateVaccineReservation(repository);
}

@Riverpod(keepAlive: true)
GetAvailableVaccinesForReservation getAvailableVaccines(Ref ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return GetAvailableVaccinesForReservation(repository);
}

@Riverpod(keepAlive: true)
WatchVaccinationRecord watchVaccinationRecord(Ref ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return WatchVaccinationRecord(repository);
}

@Riverpod(keepAlive: true)
WatchVaccinationRecords watchVaccinationRecords(Ref ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return WatchVaccinationRecords(repository);
}

@Riverpod(keepAlive: true)
GetVaccinesForSimultaneousReservation
    getAvailableVaccinesForSimultaneousReservation(Ref ref) {
  return GetVaccinesForSimultaneousReservation(
    vaccineMasterRepository: ref.watch(vaccineMasterRepositoryProvider),
    vaccinationRecordRepository: ref.watch(vaccinationRecordRepositoryProvider),
    vaccineVisibilitySettingsRepository:
        ref.watch(vaccineVisibilitySettingsRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetVaccineById getVaccineById(Ref ref) {
  final repository = ref.watch(vaccineMasterRepositoryProvider);
  return GetVaccineById(repository);
}

@Riverpod(keepAlive: true)
GetReservationGroup getReservationGroup(Ref ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return GetReservationGroup(repository);
}

@Riverpod(keepAlive: true)
VaccinationSchedulePolicy vaccinationSchedulePolicy(Ref ref) {
  return const VaccinationSchedulePolicy();
}
