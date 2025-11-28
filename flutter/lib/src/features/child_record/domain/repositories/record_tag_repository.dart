/// 記録に付与するタグを管理するリポジトリ
abstract class RecordTagRepository {
  /// 世帯のタグ一覧を取得
  Future<List<String>> fetchTags(String householdId);

  /// タグを追加
  Future<void> addTag(String householdId, String tag);

  /// タグを削除
  Future<void> removeTag(String householdId, String tag);
}
