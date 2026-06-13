import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/ad_free_repository.dart';

class AdFreeRepositoryImpl implements AdFreeRepository {
  const AdFreeRepositoryImpl(this._prefs);
  final SharedPreferences _prefs;

  static const _key = 'ad_free_until';

  @override
  int? getAdFreeUntil() => _prefs.getInt(_key);

  @override
  Future<void> setAdFreeUntil(int milliseconds) =>
      _prefs.setInt(_key, milliseconds);

  @override
  Future<void> clearAdFreeUntil() => _prefs.remove(_key);
}

class FakeAdFreeRepository implements AdFreeRepository {
  const FakeAdFreeRepository();

  static int? _value;

  @override
  int? getAdFreeUntil() => _value;

  @override
  Future<void> setAdFreeUntil(int milliseconds) async {
    _value = milliseconds;
  }

  @override
  Future<void> clearAdFreeUntil() async {
    _value = null;
  }
}
