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

/// Record追加とウィジェット同期を行う関数（householdIdごと）
@riverpod
Future<void> Function({required String childId, required Record record})
    addRecordWithWidgetSync(Ref ref, String householdId) {
  final addRecord = ref.watch(addRecordUseCaseProvider(householdId));
  final widgetSync = ref.watch(widgetDataSyncServiceProvider(householdId));

  return ({required String childId, required Record record}) async {
    await addRecord.call(childId: childId, record: record);
    // ウィジェットデータを同期
    await widgetSync.onRecordChanged(
      householdId: householdId,
      childId: childId,
    );
  };
}

/// Record削除とウィジェット同期を行う関数（householdIdごと）
@riverpod
Future<void> Function({required String childId, required String id})
    deleteRecordWithWidgetSync(Ref ref, String householdId) {
  final deleteRecord = ref.watch(deleteRecordUseCaseProvider(householdId));
  final widgetSync = ref.watch(widgetDataSyncServiceProvider(householdId));

  return ({required String childId, required String id}) async {
    await deleteRecord.call(childId: childId, id: id);
    // ウィジェットデータを同期
    await widgetSync.onRecordChanged(
      householdId: householdId,
      childId: childId,
    );
  };
}
