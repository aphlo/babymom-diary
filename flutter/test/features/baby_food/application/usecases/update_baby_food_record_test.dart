import 'package:babymom_diary/src/features/baby_food/application/usecases/update_baby_food_record.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/baby_food_item.dart';
import 'package:babymom_diary/src/features/baby_food/domain/entities/baby_food_record.dart';
import 'package:babymom_diary/src/features/baby_food/domain/repositories/baby_food_record_repository.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/baby_food_reaction.dart';
import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBabyFoodRecordRepository implements BabyFoodRecordRepository {
  final List<BabyFoodRecord> updatedRecords = [];

  @override
  Future<void> addRecord(String childId, BabyFoodRecord record) async {}

  @override
  Future<void> updateRecord(String childId, BabyFoodRecord record) async {
    updatedRecords.add(record);
  }

  @override
  Future<void> deleteRecord(String childId, String recordId) async {}

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
  group('UpdateBabyFoodRecord', () {
    late MockBabyFoodRecordRepository repository;
    late UpdateBabyFoodRecord useCase;
    late BabyFoodRecord existingRecord;

    setUp(() {
      repository = MockBabyFoodRecordRepository();
      useCase = UpdateBabyFoodRecord(repository: repository);

      existingRecord = BabyFoodRecord(
        id: 'record-1',
        recordedAt: DateTime(2024, 1, 15, 12, 0),
        items: const [
          BabyFoodItem(
            ingredientId: 'rice',
            ingredientName: '米',
            category: FoodCategory.grains,
          ),
        ],
        note: null,
        createdAt: DateTime(2024, 1, 15, 12, 0),
        updatedAt: DateTime(2024, 1, 15, 12, 0),
      );
    });

    test('食材が空の場合はArgumentErrorをスローする', () async {
      expect(
        () => useCase.call(
          childId: 'child-1',
          existingRecord: existingRecord,
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
      expect(repository.updatedRecords, isEmpty);
    });

    test('記録を正常に更新できる', () async {
      final newItems = [
        const BabyFoodItem(
          ingredientId: 'carrot',
          ingredientName: 'にんじん',
          category: FoodCategory.vegetables,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        existingRecord: existingRecord,
        recordedAt: DateTime(2024, 1, 15, 13, 0),
        items: newItems,
      );

      expect(repository.updatedRecords, hasLength(1));
      final updatedRecord = repository.updatedRecords.first;
      expect(updatedRecord.id, 'record-1'); // IDは変わらない
      expect(updatedRecord.items, equals(newItems));
      expect(updatedRecord.recordedAt, DateTime(2024, 1, 15, 13, 0));
    });

    test('メモを追加して更新できる', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'rice',
          ingredientName: '米',
          category: FoodCategory.grains,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        existingRecord: existingRecord,
        recordedAt: existingRecord.recordedAt,
        items: items,
        note: '新しいメモ',
      );

      expect(repository.updatedRecords, hasLength(1));
      final updatedRecord = repository.updatedRecords.first;
      expect(updatedRecord.note, '新しいメモ');
    });

    test('createdAtは保持され、updatedAtが更新される', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'rice',
          ingredientName: '米',
          category: FoodCategory.grains,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        existingRecord: existingRecord,
        recordedAt: existingRecord.recordedAt,
        items: items,
      );

      final updatedRecord = repository.updatedRecords.first;
      expect(updatedRecord.createdAt, existingRecord.createdAt);
      expect(
        updatedRecord.updatedAt.isAfter(existingRecord.updatedAt) ||
            updatedRecord.updatedAt.isAtSameMomentAs(existingRecord.updatedAt),
        isTrue,
      );
    });

    test('食材の反応を含めて更新できる', () async {
      final items = [
        const BabyFoodItem(
          ingredientId: 'apple',
          ingredientName: 'りんご',
          category: FoodCategory.fruits,
          reaction: BabyFoodReaction.good,
        ),
      ];

      await useCase.call(
        childId: 'child-1',
        existingRecord: existingRecord,
        recordedAt: existingRecord.recordedAt,
        items: items,
      );

      final updatedRecord = repository.updatedRecords.first;
      expect(updatedRecord.items.first.reaction, BabyFoodReaction.good);
    });
  });
}
