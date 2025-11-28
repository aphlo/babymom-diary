import '../../domain/entities/mom_daily_record.dart';
import '../../domain/entities/mom_monthly_records.dart';
import '../../domain/repositories/mom_record_repository.dart';
import '../../domain/value_objects/breast_condition.dart';
import '../../domain/value_objects/lochia_status.dart';
import '../models/mom_record_dto.dart';
import '../sources/mom_record_firestore_data_source.dart';

class MomRecordRepositoryImpl implements MomRecordRepository {
  const MomRecordRepositoryImpl({required MomRecordFirestoreDataSource remote})
      : _remote = remote;

  final MomRecordFirestoreDataSource _remote;

  @override
  Future<MomMonthlyRecords> fetchMonthlyRecords({
    required int year,
    required int month,
  }) async {
    final dtos = await _remote.fetchMonthlyRecords(year: year, month: month);
    final dtosByDay = <int, MomRecordDto>{
      for (final dto in dtos) dto.date.day: dto,
    };
    final totalDays = DateTime(year, month + 1, 0).day;
    final records = List<MomDailyRecord>.generate(totalDays, (index) {
      final day = index + 1;
      final dto = dtosByDay[day];
      return MomDailyRecord(
        date: DateTime(year, month, day),
        temperatureCelsius: dto?.temperatureCelsius,
        lochia: _toLochiaStatus(dto),
        breast: _toBreastCondition(dto),
        memo: dto?.memo,
      );
    });
    return MomMonthlyRecords(year: year, month: month, records: records);
  }

  @override
  Stream<MomDailyRecord> watchRecordForDate({
    required DateTime date,
  }) {
    return _remote.watchRecordForDate(date: date).map((dto) {
      return MomDailyRecord(
        date: date,
        temperatureCelsius: dto?.temperatureCelsius,
        lochia: _toLochiaStatus(dto),
        breast: _toBreastCondition(dto),
        memo: dto?.memo,
      );
    });
  }

  @override
  Future<void> saveRecord(MomDailyRecord record) {
    final dto = MomRecordDto(
      date: record.date,
      temperatureCelsius: record.temperatureCelsius,
      lochiaAmount: record.lochia?.amount?.code,
      lochiaColor: record.lochia?.color?.code,
      breastFirmness: record.breast?.firmness?.code,
      breastPain: record.breast?.pain?.code,
      breastRedness: record.breast?.redness?.code,
      memo: record.memo,
    );
    return _remote.upsertRecord(dto);
  }
}

LochiaStatus? _toLochiaStatus(MomRecordDto? dto) {
  if (dto == null) {
    return null;
  }
  final amount = LochiaAmount.fromCode(dto.lochiaAmount);
  final color = LochiaColor.fromCode(dto.lochiaColor);
  if (amount == null && color == null) {
    return null;
  }
  return LochiaStatus(amount: amount, color: color);
}

BreastCondition? _toBreastCondition(MomRecordDto? dto) {
  if (dto == null) {
    return null;
  }
  final firmness = SymptomIntensity.fromCode(dto.breastFirmness);
  final pain = SymptomIntensity.fromCode(dto.breastPain);
  final redness = SymptomIntensity.fromCode(dto.breastRedness);
  if (firmness == null && pain == null && redness == null) {
    return null;
  }
  return BreastCondition(
    firmness: firmness,
    pain: pain,
    redness: redness,
  );
}
