import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_master.dart';

class InMemoryVaccineCatalogRepository implements VaccineCatalogRepository {
  const InMemoryVaccineCatalogRepository();

  @override
  Future<VaccineMaster> fetchGuideline() async {
    return japaneseNationalVaccinationMaster;
  }
}
