import '../../domain/entities/mom_diary_entry.dart';
import '../../domain/entities/mom_diary_month.dart';
import '../../domain/repositories/mom_diary_repository.dart';

/// 月間日記を一度だけ取得するUseCase
class GetMomDiaryMonthlyEntries {
  const GetMomDiaryMonthlyEntries(this._repository);

  final MomDiaryRepository _repository;

  Future<MomDiaryMonth> call({
    required int year,
    required int month,
  }) {
    return _repository.fetchMonthlyDiary(year: year, month: month);
  }
}

/// 特定の日付の日記をリアルタイムで監視するUseCase
class WatchMomDiaryForDate {
  const WatchMomDiaryForDate(this._repository);

  final MomDiaryRepository _repository;

  Stream<MomDiaryEntry> call({
    required DateTime date,
  }) {
    return _repository.watchDiaryForDate(date: date);
  }
}
