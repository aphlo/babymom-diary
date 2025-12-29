import '../../domain/repositories/baby_food_record_repository.dart';

/// 離乳食記録を削除するユースケース
class DeleteBabyFoodRecord {
  DeleteBabyFoodRecord({
    required BabyFoodRecordRepository repository,
  }) : _repository = repository;

  final BabyFoodRecordRepository _repository;

  Future<void> call({
    required String childId,
    required String recordId,
  }) async {
    await _repository.deleteRecord(childId, recordId);
  }
}
