import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/menu/data_management/domain/repositories/data_management_repository.dart';
import 'package:babymom_diary/src/features/menu/data_management/infrastructure/repositories/data_management_repository_impl.dart';
import 'package:babymom_diary/src/features/menu/data_management/application/usecases/delete_all_household_data.dart';

part 'data_management_providers.g.dart';

/// Provider for DataManagementRepository
@riverpod
DataManagementRepository dataManagementRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return DataManagementRepositoryImpl(firestore);
}

/// Provider for DeleteAllHouseholdData use case
@riverpod
DeleteAllHouseholdData deleteAllHouseholdData(Ref ref) {
  final repository = ref.watch(dataManagementRepositoryProvider);
  return DeleteAllHouseholdData(repository);
}
