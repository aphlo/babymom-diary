/// Repository for managing household data operations such as deletion.
abstract class DataManagementRepository {
  /// Deletes all household data except members subcollection.
  ///
  /// This will delete:
  /// - All children documents and their subcollections:
  ///   - vaccination_records (ワクチン接種記録)
  ///   - reservation_groups (予約グループ)
  ///   - childRecords (子どもの日々の記録)
  ///   - growthRecords (成長記録)
  /// - events (カレンダーイベント)
  /// - momDiary (ママの日記)
  /// - momRecords (ママの記録)
  /// - settings (設定)
  /// - invitations (招待情報)
  ///
  /// This will NOT delete:
  /// - The members subcollection (to preserve household sharing relationships)
  /// - The household document itself
  ///
  /// Returns a Future that completes when all data is deleted.
  Future<void> deleteAllHouseholdData(String householdId);
}
