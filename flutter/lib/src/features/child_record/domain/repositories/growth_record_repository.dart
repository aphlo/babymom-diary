import '../entities/growth_record.dart';

abstract class GrowthRecordRepository {
  Stream<List<GrowthRecord>> watchRecords({
    required String childId,
  });

  Future<List<GrowthRecord>> fetchRecords({
    required String childId,
  });

  Future<GrowthRecord> addRecord({
    required GrowthRecord record,
  });

  Future<GrowthRecord> updateRecord({
    required GrowthRecord record,
  });

  Future<void> deleteRecord(String childId, String recordId);
}
