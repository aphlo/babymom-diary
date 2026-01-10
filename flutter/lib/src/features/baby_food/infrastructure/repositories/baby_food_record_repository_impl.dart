import '../../domain/entities/baby_food_record.dart';
import '../../domain/repositories/baby_food_record_repository.dart';
import '../sources/baby_food_firestore_data_source.dart';

/// 離乳食記録リポジトリの実装
class BabyFoodRecordRepositoryImpl implements BabyFoodRecordRepository {
  BabyFoodRecordRepositoryImpl({
    required BabyFoodFirestoreDataSource dataSource,
  }) : _dataSource = dataSource;

  final BabyFoodFirestoreDataSource _dataSource;

  @override
  Future<List<BabyFoodRecord>> getRecordsForDay(String childId, DateTime day) {
    return _dataSource.getForDay(childId, day);
  }

  @override
  Stream<List<BabyFoodRecord>> watchRecordsForDay(
      String childId, DateTime day) {
    return _dataSource.watchForDay(childId, day);
  }

  @override
  Stream<List<BabyFoodRecord>> watchAllRecords(String childId) {
    return _dataSource.watchAll(childId);
  }

  @override
  Future<void> addRecord(String childId, BabyFoodRecord record) {
    return _dataSource.add(childId, record);
  }

  @override
  Future<void> updateRecord(String childId, BabyFoodRecord record) {
    return _dataSource.update(childId, record);
  }

  @override
  Future<void> deleteRecord(String childId, String recordId) {
    return _dataSource.delete(childId, recordId);
  }
}
