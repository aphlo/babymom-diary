import '../entities/mom_diary_entry.dart';
import '../entities/mom_diary_month.dart';

abstract class MomDiaryRepository {
  /// 月間日記を一度だけ取得（リアルタイム更新なし）
  Future<MomDiaryMonth> fetchMonthlyDiary({
    required int year,
    required int month,
  });

  /// 特定の日付の日記をリアルタイムで監視
  Stream<MomDiaryEntry> watchDiaryForDate({
    required DateTime date,
  });

  Future<void> saveDiaryEntry(MomDiaryEntry entry);
}
