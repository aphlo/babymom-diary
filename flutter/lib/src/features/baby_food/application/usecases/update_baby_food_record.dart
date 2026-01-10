import '../../domain/entities/baby_food_item.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/repositories/baby_food_record_repository.dart';

/// 離乳食記録を更新するユースケース
class UpdateBabyFoodRecord {
  UpdateBabyFoodRecord({
    required BabyFoodRecordRepository repository,
  }) : _repository = repository;

  final BabyFoodRecordRepository _repository;

  Future<BabyFoodRecord> call({
    required String childId,
    required BabyFoodRecord existingRecord,
    required DateTime recordedAt,
    required List<BabyFoodItem> items,
    String? note,
  }) async {
    if (items.isEmpty) {
      throw ArgumentError('食材を1つ以上選択してください');
    }

    final updatedRecord = existingRecord.copyWith(
      recordedAt: recordedAt,
      items: items,
      note: note,
      updatedAt: DateTime.now(),
    );

    await _repository.updateRecord(childId, updatedRecord);
    return updatedRecord;
  }
}
