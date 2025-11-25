import '../../domain/entities/mom_diary_month.dart';
import '../../domain/repositories/mom_diary_repository.dart';

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

/// リアルタイム更新用のUseCase
class WatchMomDiaryMonthlyEntries {
  const WatchMomDiaryMonthlyEntries(this._repository);

  final MomDiaryRepository _repository;

  Stream<MomDiaryMonth> call({
    required int year,
    required int month,
  }) {
    return _repository.watchMonthlyDiary(year: year, month: month);
  }
}
