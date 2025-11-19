import 'package:babymom_diary/src/features/menu/data_management/domain/repositories/data_management_repository.dart';

/// Use case for deleting all household data except members subcollection.
///
/// This will remove all data associated with a household while preserving
/// the household sharing relationships (members).
class DeleteAllHouseholdData {
  DeleteAllHouseholdData(this._repository);

  final DataManagementRepository _repository;

  /// Executes the data deletion for the specified household.
  ///
  /// [householdId] The ID of the household to delete data from.
  ///
  /// Returns a Future that completes when all data is deleted.
  Future<void> execute(String householdId) async {
    await _repository.deleteAllHouseholdData(householdId);
  }
}
