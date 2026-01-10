import 'package:babymom_diary/src/features/baby_food/application/usecases/delete_baby_food_record.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/baby_food_record.dart';
import 'package:babymom_diary/src/features/baby_food/domain/repositories/baby_food_record_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBabyFoodRecordRepository implements BabyFoodRecordRepository {
  final List<(String childId, String recordId)> deletedRecords = [];

  @override
  Future<void> addRecord(String childId, BabyFoodRecord record) async {}

  @override
  Future<void> updateRecord(String childId, BabyFoodRecord record) async {}

  @override
  Future<void> deleteRecord(String childId, String recordId) async {
    deletedRecords.add((childId, recordId));
  }

  @override
  Future<List<BabyFoodRecord>> getRecordsForDay(
      String childId, DateTime day) async {
    return [];
  }

  @override
  Stream<List<BabyFoodRecord>> watchRecordsForDay(
      String childId, DateTime day) {
    return Stream.value([]);
  }

  @override
  Stream<List<BabyFoodRecord>> watchAllRecords(String childId) {
    return Stream.value([]);
  }
}

void main() {
  group('DeleteBabyFoodRecord', () {
    late MockBabyFoodRecordRepository repository;
    late DeleteBabyFoodRecord useCase;

    setUp(() {
      repository = MockBabyFoodRecordRepository();
      useCase = DeleteBabyFoodRecord(repository: repository);
    });

    test('指定したchildIdとrecordIdで削除が呼ばれる', () async {
      await useCase.call(
        childId: 'child-1',
        recordId: 'record-123',
      );

      expect(repository.deletedRecords, hasLength(1));
      expect(repository.deletedRecords.first.$1, 'child-1');
      expect(repository.deletedRecords.first.$2, 'record-123');
    });

    test('複数回削除を呼び出せる', () async {
      await useCase.call(childId: 'child-1', recordId: 'record-1');
      await useCase.call(childId: 'child-1', recordId: 'record-2');
      await useCase.call(childId: 'child-2', recordId: 'record-3');

      expect(repository.deletedRecords, hasLength(3));
      expect(repository.deletedRecords[0], ('child-1', 'record-1'));
      expect(repository.deletedRecords[1], ('child-1', 'record-2'));
      expect(repository.deletedRecords[2], ('child-2', 'record-3'));
    });
  });
}
