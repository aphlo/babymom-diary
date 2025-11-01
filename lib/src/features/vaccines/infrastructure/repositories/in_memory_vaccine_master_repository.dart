import '../../domain/entities/vaccine.dart';
import '../../domain/repositories/vaccine_master_repository.dart';
import '../../domain/specifications/vaccine_guideline_data.dart';

class InMemoryVaccineMasterRepository implements VaccineMasterRepository {
  const InMemoryVaccineMasterRepository();

  @override
  Future<Vaccine?> getVaccineById(String vaccineId) async {
    try {
      return japaneseNationalVaccinationGuideline.vaccines.firstWhere(
        (vaccine) => vaccine.id == vaccineId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Vaccine>> getAllVaccines() async {
    return japaneseNationalVaccinationGuideline.vaccines;
  }

  @override
  Future<Vaccine?> getVaccineByName(String vaccineName) async {
    try {
      return japaneseNationalVaccinationGuideline.vaccines.firstWhere(
        (vaccine) => vaccine.name == vaccineName,
      );
    } catch (e) {
      return null;
    }
  }
}
