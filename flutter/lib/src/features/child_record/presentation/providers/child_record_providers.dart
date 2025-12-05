import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../widget/application/providers/widget_providers.dart';
import '../../application/usecases/add_record.dart';
import '../../application/usecases/delete_record.dart';
import '../../domain/entities/record.dart';
import '../../domain/repositories/child_record_repository.dart';
import '../../infrastructure/repositories/child_record_repository_impl.dart';

part 'child_record_providers.g.dart';

/// ChildRecordRepository の Provider（householdId ごと）
@riverpod
ChildRecordRepository childRecordRepository(Ref ref, String householdId) {
  return ChildRecordRepositoryImpl(householdId);
}

/// AddRecord UseCase の Provider（householdId ごと）
@riverpod
AddRecord addRecordUseCase(Ref ref, String householdId) {
  final repository = ref.watch(childRecordRepositoryProvider(householdId));
  return AddRecord(repository);
}

/// DeleteRecord UseCase の Provider（householdId ごと）
@riverpod
DeleteRecord deleteRecordUseCase(Ref ref, String householdId) {
  final repository = ref.watch(childRecordRepositoryProvider(householdId));
  return DeleteRecord(repository);
}

/// Record追加/更新とウィジェット同期を行う関数（householdIdごと）
///
/// Firestore保存は必須、ウィジェット同期は失敗してもエラーとしない。
/// ウィジェット同期の失敗は次回アプリ起動時のフル同期で回復される。
@riverpod
Future<void> Function({required String childId, required Record record})
    addRecordWithWidgetSync(Ref ref, String householdId) {
  final addRecord = ref.watch(addRecordUseCaseProvider(householdId));
  final widgetSync = ref.watch(widgetDataSyncServiceProvider(householdId));

  return ({required String childId, required Record record}) async {
    // Firestoreに保存（これが失敗したらエラー）
    await addRecord.call(childId: childId, record: record);

    // ウィジェットデータを同期（失敗してもエラーとしない）
    try {
      // ignore: avoid_print
      print('[Widget] Starting widget sync for record: ${record.type}');
      await widgetSync.onRecordAdded(
        childId: childId,
        record: record,
      );
      // ignore: avoid_print
      print('[Widget] Widget sync completed successfully');
    } catch (e) {
      // ignore: avoid_print
      print('[Widget] Widget sync failed: $e');
      // ウィジェット同期失敗はサイレントに処理
      // 次回アプリ起動時のフル同期で整合性が回復される
    }
  };
}

/// Record削除とウィジェット同期を行う関数（householdIdごと）
///
/// Firestore削除は必須、ウィジェット同期は失敗してもエラーとしない。
@riverpod
Future<void> Function({required String childId, required String id})
    deleteRecordWithWidgetSync(Ref ref, String householdId) {
  final deleteRecord = ref.watch(deleteRecordUseCaseProvider(householdId));
  final widgetSync = ref.watch(widgetDataSyncServiceProvider(householdId));

  return ({required String childId, required String id}) async {
    // Firestoreから削除（これが失敗したらエラー）
    await deleteRecord.call(childId: childId, id: id);

    // ウィジェットデータを同期（失敗してもエラーとしない）
    try {
      await widgetSync.onRecordDeleted(
        childId: childId,
        recordId: id,
      );
    } catch (e) {
      // ウィジェット同期失敗はサイレントに処理
    }
  };
}
