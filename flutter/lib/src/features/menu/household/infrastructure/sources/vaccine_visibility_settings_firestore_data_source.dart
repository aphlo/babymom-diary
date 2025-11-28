import 'package:cloud_firestore/cloud_firestore.dart';

/// ワクチン表示設定のFirestoreデータソース
class VaccineVisibilitySettingsFirestoreDataSource {
  VaccineVisibilitySettingsFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  /// 世帯ドキュメントへの参照を取得
  DocumentReference<Map<String, dynamic>> _householdRef(String householdId) {
    return _firestore.collection('households').doc(householdId);
  }

  /// ワクチン表示設定を取得
  ///
  /// `households/{householdId}`ドキュメントの`vaccineVisibilitySettings`フィールドを取得します。
  /// フィールドが存在しない場合は空のマップを返します。
  Future<Map<String, bool>> getSettings({
    required String householdId,
  }) async {
    try {
      final doc = await _householdRef(householdId).get();
      final data = doc.data();

      if (data == null || !data.containsKey('vaccineVisibilitySettings')) {
        return {};
      }

      final settingsData = data['vaccineVisibilitySettings'];
      if (settingsData is! Map) {
        return {};
      }

      // Map<String, dynamic>からMap<String, bool>に変換
      final result = <String, bool>{};
      settingsData.forEach((key, value) {
        if (key is String && value is bool) {
          result[key] = value;
        }
      });

      return result;
    } on FirebaseException catch (e) {
      throw Exception(
          'Failed to get vaccine visibility settings for household $householdId: [${e.code}] ${e.message}');
    } catch (e) {
      throw Exception(
          'Failed to get vaccine visibility settings for household $householdId: $e');
    }
  }

  /// ワクチン表示設定を更新
  ///
  /// `households/{householdId}`ドキュメントの`vaccineVisibilitySettings`フィールドを更新します。
  Future<void> updateSettings({
    required String householdId,
    required Map<String, bool> visibilityMap,
  }) async {
    try {
      await _householdRef(householdId).set(
        {
          'vaccineVisibilitySettings': visibilityMap,
        },
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      throw Exception(
          'Failed to update vaccine visibility settings for household $householdId: [${e.code}] ${e.message}');
    } catch (e) {
      throw Exception(
          'Failed to update vaccine visibility settings for household $householdId: $e');
    }
  }
}
