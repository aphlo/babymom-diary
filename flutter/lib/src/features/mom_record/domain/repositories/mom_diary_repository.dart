import '../entities/mom_diary_entry.dart';
import '../entities/mom_diary_month.dart';

abstract class MomDiaryRepository {
  Future<MomDiaryMonth> fetchMonthlyDiary({
    required int year,
    required int month,
  });

  /// リアルタイム更新用のStream版
  Stream<MomDiaryMonth> watchMonthlyDiary({
    required int year,
    required int month,
  });

  Future<void> saveDiaryEntry(MomDiaryEntry entry);
}
