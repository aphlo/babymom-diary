import '../../domain/entities/baby_food_record.dart';
import '../../domain/repositories/baby_food_record_repository.dart';

/// 離乳食記録を監視するユースケース
class WatchBabyFoodRecords {
  WatchBabyFoodRecords({
    required BabyFoodRecordRepository repository,
  }) : _repository = repository;

  final BabyFoodRecordRepository _repository;

  Stream<List<BabyFoodRecord>> call({
    required String childId,
    required DateTime day,
  }) {
    return _repository.watchRecordsForDay(childId, day);
  }
}
