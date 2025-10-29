import '../../child_record.dart';

class WatchGrowthRecords {
  const WatchGrowthRecords(this._repository);

  final GrowthRecordRepository _repository;

  Stream<List<GrowthRecord>> call(String childId) {
    return _repository.watchRecords(childId: childId);
  }
}
