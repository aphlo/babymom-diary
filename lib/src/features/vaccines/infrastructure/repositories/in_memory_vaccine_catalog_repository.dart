import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_guideline.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/domain/specifications/vaccine_guideline_data.dart';

class InMemoryVaccineCatalogRepository implements VaccineCatalogRepository {
  const InMemoryVaccineCatalogRepository();

  @override
  Future<VaccineGuideline> fetchGuideline() async {
    return japaneseNationalVaccinationGuideline;
  }
}
