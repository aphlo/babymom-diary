abstract class AdFreeRepository {
  int? getAdFreeUntil();
  Future<void> setAdFreeUntil(int milliseconds);
  Future<void> clearAdFreeUntil();
}
