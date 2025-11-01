import '../entities/vaccine_guideline.dart';

abstract class VaccineCatalogRepository {
  Future<VaccineGuideline> fetchGuideline();
}
