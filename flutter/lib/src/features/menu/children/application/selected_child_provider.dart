import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'selected_child_provider.g.dart';

/// Persisted selected child id
@Riverpod(keepAlive: true)
class SelectedChildController extends _$SelectedChildController {
  static const _prefsKey = 'selectedChildId';

  @override
  Future<String?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_prefsKey);
    // Treat empty string as null for cleanliness
    return (v == null || v.isEmpty) ? null : v;
  }

  Future<void> select(String? id) async {
    state = AsyncData(id);
    final prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(_prefsKey);
    } else {
      await prefs.setString(_prefsKey, id);
    }
  }
}
