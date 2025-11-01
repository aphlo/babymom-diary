import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_master_repository.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccination_record_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/in_memory_vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/in_memory_vaccine_master_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/vaccination_record_repository_impl.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/sources/vaccination_record_firestore_data_source.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_guideline.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/create_vaccine_reservation.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_available_vaccines_for_reservation.dart';

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

final getVaccineGuidelineProvider = Provider<GetVaccineGuideline>((ref) {
  final repository = ref.watch(vaccineCatalogRepositoryProvider);
  return GetVaccineGuideline(repository);
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
