import '../../domain/entities/baby_food_item.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/repositories/baby_food_record_repository.dart';

/// 離乳食記録を追加するユースケース
class AddBabyFoodRecord {
  AddBabyFoodRecord({
    required BabyFoodRecordRepository repository,
  }) : _repository = repository;

  final BabyFoodRecordRepository _repository;

  Future<BabyFoodRecord> call({
    required String childId,
    required DateTime recordedAt,
    required List<BabyFoodItem> items,
    String? note,
  }) async {
    if (items.isEmpty) {
      throw ArgumentError('食材を1つ以上選択してください');
    }

    final now = DateTime.now();
    final record = BabyFoodRecord(
      id: generateBabyFoodRecordId(childId: childId, recordedAt: recordedAt),
      recordedAt: recordedAt,
      items: items,
      note: note,
      createdAt: now,
      updatedAt: now,
    );

    await _repository.addRecord(childId, record);
    return record;
  }
}
