import '../entities/vaccine.dart';

abstract class VaccineMasterRepository {
  /// 指定されたIDのワクチン情報を取得
  Future<Vaccine?> getVaccineById(String vaccineId);

  /// 全てのワクチン情報を取得
  Future<List<Vaccine>> getAllVaccines();

  /// ワクチン名からワクチン情報を取得
  Future<Vaccine?> getVaccineByName(String vaccineName);
}
