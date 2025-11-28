import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/usecases/add_record.dart';
import '../../application/usecases/delete_record.dart';
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
