import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedChildController extends AsyncNotifier<String?> {
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

/// Persisted selected child id
final selectedChildControllerProvider =
    AsyncNotifierProvider<SelectedChildController, String?>(
  SelectedChildController.new,
);
