import '../entities/vaccine_master.dart';

abstract class VaccineCatalogRepository {
  Future<VaccineMaster> fetchGuideline();
}
