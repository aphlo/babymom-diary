import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_catalog_repository.dart';

class GetVaccineMaster {
  const GetVaccineMaster(this._repository);

  final VaccineCatalogRepository _repository;

  Future<VaccineMaster> call() {
    return _repository.fetchGuideline();
  }
}
