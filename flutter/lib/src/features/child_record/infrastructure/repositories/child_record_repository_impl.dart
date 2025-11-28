import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/record.dart';
import '../../domain/repositories/child_record_repository.dart';
import '../sources/record_firestore_data_source.dart';

class ChildRecordRepositoryImpl implements ChildRecordRepository {
  ChildRecordRepositoryImpl(this._householdId);

  final String _householdId;

  RecordFirestoreDataSource get _dataSource =>
      RecordFirestoreDataSource(FirebaseFirestore.instance, _householdId);

  @override
  Future<void> addRecord(String childId, Record record) =>
      _dataSource.upsert(childId, record);

  @override
  Future<void> deleteRecord(String childId, String id) =>
      _dataSource.delete(childId, id);

  @override
  Future<List<Record>> getRecordsForDay(String childId, DateTime day) =>
      _dataSource.getForDay(childId, day);
}
