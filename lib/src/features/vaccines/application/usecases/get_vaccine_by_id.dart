import '../../domain/entities/vaccine.dart';
import '../../domain/repositories/vaccine_master_repository.dart';

class GetVaccineById {
  const GetVaccineById(this._repository);

  final VaccineMasterRepository _repository;

  Future<Vaccine?> call(String vaccineId) {
    return _repository.getVaccineById(vaccineId);
  }
}
