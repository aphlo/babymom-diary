import '../../baby_log.dart';

class AddEntry {
  final LogRepository repo;
  AddEntry(this.repo);
  Future<void> call(Entry entry) => repo.addEntry(entry);
}