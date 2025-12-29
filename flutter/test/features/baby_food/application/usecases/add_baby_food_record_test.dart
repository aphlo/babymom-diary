import 'package:babymom_diary/src/features/baby_food/application/usecases/add_baby_food_record.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/baby_food_item.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/baby_food_record.dart';
import 'package:babymom_diary/src/features/baby_food/domain/repositories/baby_food_record_repository.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBabyFoodRecordRepository implements BabyFoodRecordRepository {
  final List<BabyFoodRecord> addedRecords = [];
  final List<BabyFoodRecord> updatedRecords = [];
  final List<String> deletedRecordIds = [];

  @override
  Future<void> addRecord(String childId, BabyFoodRecord record) async {
    addedRecords.add(record);
  }

  @override
  Future<void> updateRecord(String childId, BabyFoodRecord record) async {
    updatedRecords.add(record);
  }

  @override
  Future<void> deleteRecord(String childId, String recordId) async {
    deletedRecordIds.add(recordId);
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
  group('AddBabyFoodRecord', () {
    late MockBabyFoodRecordRepository repository;
    late AddBabyFoodRecord useCase;

    setUp(() {
      repository = MockBabyFoodRecordRepository();
      useCase = AddBabyFoodRecord(repository: repository);
    });

    test('食材が空の場合はArgumentErrorをスローする', () async {
      expect(
        () => useCase.call(
          childId: 'child-1',
          recordedAt: DateTime(2024, 1, 15, 12, 0),
          items: [],
        ),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          '食材を1つ以上選択してください',
        )),
      );

      // リポジトリが呼ばれていないことを確認
      expect(repository.addedRecords, isEmpty);
    });

    test('食材が1つ以上ある場合は正常に記録を追加する', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'rice',
          ingredientName: '米',
          category: FoodCategory.grains,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        recordedAt: DateTime(2024, 1, 15, 12, 0),
        items: items,
      );

      expect(repository.addedRecords, hasLength(1));
      final addedRecord = repository.addedRecords.first;
      expect(addedRecord.items, equals(items));
      expect(addedRecord.recordedAt, DateTime(2024, 1, 15, 12, 0));
      expect(addedRecord.note, isNull);
    });

    test('メモ付きで記録を追加できる', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'carrot',
          ingredientName: 'にんじん',
          category: FoodCategory.vegetables,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        recordedAt: DateTime(2024, 1, 15, 12, 30),
        items: items,
        note: 'よく食べた',
      );

      expect(repository.addedRecords, hasLength(1));
      final addedRecord = repository.addedRecords.first;
      expect(addedRecord.note, 'よく食べた');
    });

    test('複数の食材を含む記録を追加できる', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'rice',
          ingredientName: '米',
          category: FoodCategory.grains,
        ),
        const BabyFoodItem(
          ingredientId: 'carrot',
          ingredientName: 'にんじん',
          category: FoodCategory.vegetables,
        ),
        const BabyFoodItem(
          ingredientId: 'tofu',
          ingredientName: '豆腐',
          category: FoodCategory.soy,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        recordedAt: DateTime(2024, 1, 15, 18, 0),
        items: items,
      );

      expect(repository.addedRecords, hasLength(1));
      final addedRecord = repository.addedRecords.first;
      expect(addedRecord.items, hasLength(3));
    });

    test('生成されるIDにchildIdと日時が含まれる', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'rice',
          ingredientName: '米',
          category: FoodCategory.grains,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        recordedAt: DateTime(2024, 1, 15, 12, 30),
        items: items,
      );

      final addedRecord = repository.addedRecords.first;
      expect(addedRecord.id, startsWith('babyfood-2024-01-15-1230'));
    });
  });
}
