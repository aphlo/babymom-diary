import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
import 'package:babymom_diary/src/features/vaccines/domain/services/influenza_schedule_generator.dart';

final vaccineCatalogRepositoryProvider =
    Provider<VaccineCatalogRepository>((ref) {
  return const InMemoryVaccineCatalogRepository();
});

final vaccineMasterRepositoryProvider =
    Provider<VaccineMasterRepository>((ref) {
  return const InMemoryVaccineMasterRepository();
});

final vaccinationRecordDataSourceProvider =
    Provider<VaccinationRecordFirestoreDataSource>((ref) {
  final vaccineMasterRepository = ref.watch(vaccineMasterRepositoryProvider);
  return VaccinationRecordFirestoreDataSource(
    FirebaseFirestore.instance,
    vaccineMasterRepository,
  );
});

final vaccinationRecordRepositoryProvider =
    Provider<VaccinationRecordRepository>((ref) {
  final dataSource = ref.watch(vaccinationRecordDataSourceProvider);
  return VaccinationRecordRepositoryImpl(
    dataSource,
  );
});

final getVaccineGuidelineProvider = Provider<GetVaccineMaster>((ref) {
  final repository = ref.watch(vaccineCatalogRepositoryProvider);
  return GetVaccineMaster(repository);
});

final createVaccineReservationProvider =
    Provider<CreateVaccineReservation>((ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return CreateVaccineReservation(repository);
});

final getAvailableVaccinesProvider =
    Provider<GetAvailableVaccinesForReservation>((ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return GetAvailableVaccinesForReservation(repository);
});

final watchVaccinationRecordProvider = Provider<WatchVaccinationRecord>((ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return WatchVaccinationRecord(repository);
});

final watchVaccinationRecordsProvider =
    Provider<WatchVaccinationRecords>((ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return WatchVaccinationRecords(repository);
});

final getAvailableVaccinesForSimultaneousReservationProvider =
    Provider<GetVaccinesForSimultaneousReservation>(
  (ref) => GetVaccinesForSimultaneousReservation(
    vaccineMasterRepository: ref.watch(vaccineMasterRepositoryProvider),
    vaccinationRecordRepository: ref.watch(vaccinationRecordRepositoryProvider),
  ),
);

final getVaccineByIdProvider = Provider<GetVaccineById>((ref) {
  final repository = ref.watch(vaccineMasterRepositoryProvider);
  return GetVaccineById(repository);
});

final getReservationGroupProvider = Provider<GetReservationGroup>((ref) {
  final repository = ref.watch(vaccinationRecordRepositoryProvider);
  return GetReservationGroup(repository);
});

final vaccinationSchedulePolicyProvider =
    Provider<VaccinationSchedulePolicy>((ref) {
  return const VaccinationSchedulePolicy();
});

final influenzaScheduleGeneratorProvider =
    Provider<InfluenzaScheduleGenerator>((ref) {
  return const InfluenzaScheduleGenerator();
});
