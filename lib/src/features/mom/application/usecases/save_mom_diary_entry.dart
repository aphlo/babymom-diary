import '../../domain/entities/mom_diary_entry.dart';
import '../../domain/repositories/mom_diary_repository.dart';

class SaveMomDiaryEntry {
  const SaveMomDiaryEntry(this._repository);

  final MomDiaryRepository _repository;

  Future<void> call(MomDiaryEntry entry) {
    return _repository.saveDiaryEntry(entry);
  }
}
