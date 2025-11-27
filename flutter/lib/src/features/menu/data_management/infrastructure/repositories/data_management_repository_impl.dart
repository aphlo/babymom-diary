import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babymom_diary/src/features/menu/data_management/domain/repositories/data_management_repository.dart';

/// Implementation of [DataManagementRepository] using Cloud Firestore.
class DataManagementRepositoryImpl implements DataManagementRepository {
  DataManagementRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;
  static const int _batchSize = 500;

  @override
  Future<void> deleteAllHouseholdData(String householdId) async {
    final householdRef = _firestore.collection('households').doc(householdId);

    // Delete all children and their subcollections
    await _deleteChildren(householdRef);

    // Delete calendar events (collection name is 'events' not 'calendar_events')
    await _deleteCollection(householdRef.collection('events'));

    // Delete mom diaries (collection name is 'momDiary' not 'mom_diaries')
    await _deleteCollection(householdRef.collection('momDiary'));

    // Delete mom records (collection name is 'momRecords' not 'mom_records')
    await _deleteCollection(householdRef.collection('momRecords'));

    // Delete vaccine_visibility_settings
    await _deleteCollection(householdRef.collection('settings'));
  }

  /// Deletes all children and their subcollections
  Future<void> _deleteChildren(DocumentReference householdRef) async {
    final childrenSnapshot = await householdRef.collection('children').get();

    for (final childDoc in childrenSnapshot.docs) {
      // Delete child's vaccination_records
      await _deleteCollection(
          childDoc.reference.collection('vaccination_records'));

      // Delete child's reservation_groups
      await _deleteCollection(
          childDoc.reference.collection('reservation_groups'));

      // Delete child's daily records (childRecords)
      await _deleteCollection(childDoc.reference.collection('childRecords'));

      // Delete child's growth records (growthRecords)
      await _deleteCollection(childDoc.reference.collection('growthRecords'));

      // Delete the child document itself
      await childDoc.reference.delete();
    }
  }

  /// Deletes all documents in a collection using batched writes
  Future<void> _deleteCollection(CollectionReference collection) async {
    final snapshot = await collection.get();

    if (snapshot.docs.isEmpty) {
      return;
    }

    // Split into batches of 500 or less
    final batches = <WriteBatch>[];
    var currentBatch = _firestore.batch();
    var operationCount = 0;

    for (final doc in snapshot.docs) {
      currentBatch.delete(doc.reference);
      operationCount++;

      if (operationCount >= _batchSize) {
        batches.add(currentBatch);
        currentBatch = _firestore.batch();
        operationCount = 0;
      }
    }

    // Add the last batch if it has operations
    if (operationCount > 0) {
      batches.add(currentBatch);
    }

    // Commit all batches
    for (final batch in batches) {
      await batch.commit();
    }
  }
}
