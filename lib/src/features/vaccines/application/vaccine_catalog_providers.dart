import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/in_memory_vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_guideline.dart';

final vaccineCatalogRepositoryProvider =
    Provider<VaccineCatalogRepository>((ref) {
  return const InMemoryVaccineCatalogRepository();
});

final getVaccineGuidelineProvider = Provider<GetVaccineGuideline>((ref) {
  final repository = ref.watch(vaccineCatalogRepositoryProvider);
  return GetVaccineGuideline(repository);
});
