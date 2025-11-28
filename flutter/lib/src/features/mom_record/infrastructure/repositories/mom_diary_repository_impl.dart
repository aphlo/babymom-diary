import '../../domain/entities/mom_diary_entry.dart';
import '../../domain/entities/mom_diary_month.dart';
import '../../domain/repositories/mom_diary_repository.dart';
import '../models/mom_diary_dto.dart';
import '../sources/mom_diary_firestore_data_source.dart';

class MomDiaryRepositoryImpl implements MomDiaryRepository {
  const MomDiaryRepositoryImpl({
    required MomDiaryFirestoreDataSource remote,
  }) : _remote = remote;

  final MomDiaryFirestoreDataSource _remote;

  @override
  Future<MomDiaryMonth> fetchMonthlyDiary({
    required int year,
    required int month,
  }) async {
    final dtos = await _remote.fetchMonthlyDiary(year: year, month: month);
    final dtosByDay = <int, MomDiaryDto>{
      for (final dto in dtos) dto.date.day: dto,
    };
    final totalDays = DateTime(year, month + 1, 0).day;
    final entries = List<MomDiaryEntry>.generate(totalDays, (index) {
      final day = index + 1;
      final dto = dtosByDay[day];
      return MomDiaryEntry(
        date: DateTime(year, month, day),
        content: dto?.content,
      );
    });
    return MomDiaryMonth(year: year, month: month, entries: entries);
  }

  @override
  Stream<MomDiaryEntry> watchDiaryForDate({
    required DateTime date,
  }) {
    return _remote.watchDiaryForDate(date: date).map((dto) {
      return MomDiaryEntry(
        date: date,
        content: dto?.content,
      );
    });
  }

  @override
  Future<void> saveDiaryEntry(MomDiaryEntry entry) {
    final dto = MomDiaryDto(
      date: entry.date,
      content: entry.content,
    );
    return _remote.upsertDiary(dto);
  }
}
