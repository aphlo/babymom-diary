import '../../child_record.dart';
import '../sources/growth_record_firestore_data_source.dart';

class GrowthRecordRepositoryImpl implements GrowthRecordRepository {
  GrowthRecordRepositoryImpl({required GrowthRecordFirestoreDataSource remote})
      : _remote = remote;

  final GrowthRecordFirestoreDataSource _remote;

  @override
  Future<GrowthRecord> addRecord({required GrowthRecord record}) {
    return _remote.addRecord(record);
  }

  @override
  Future<void> deleteRecord(String childId, String recordId) {
    return _remote.deleteRecord(childId, recordId);
  }

  @override
  Future<List<GrowthRecord>> fetchRecords({required String childId}) {
    return _remote.fetchRecords(childId);
  }

  @override
  Future<GrowthRecord> updateRecord({required GrowthRecord record}) {
    return _remote.updateRecord(record);
  }

  @override
  Stream<List<GrowthRecord>> watchRecords({required String childId}) {
    return _remote.watchRecords(childId);
  }
}
