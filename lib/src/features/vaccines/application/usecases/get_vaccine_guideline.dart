import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_guideline.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';

class GetVaccineGuideline {
  const GetVaccineGuideline(this._repository);

  final VaccineCatalogRepository _repository;

  Future<VaccineGuideline> call() {
    return _repository.fetchGuideline();
  }
}
