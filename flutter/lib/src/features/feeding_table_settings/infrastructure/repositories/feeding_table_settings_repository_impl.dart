import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/core/preferences/shared_preferences_provider.dart';
import 'package:babymom_diary/src/features/feeding_table_settings/domain/entities/feeding_table_settings.dart';
import 'package:babymom_diary/src/features/feeding_table_settings/domain/repositories/feeding_table_settings_repository.dart';

part 'feeding_table_settings_repository_impl.g.dart';

class FeedingTableSettingsRepositoryImpl
    implements FeedingTableSettingsRepository {
  FeedingTableSettingsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyVisibleCategories =
      'feeding_table_visible_categories';

  final StreamController<FeedingTableSettings> _settingsController =
      StreamController<FeedingTableSettings>.broadcast();

  @override
  Future<FeedingTableSettings> getSettings() async {
    final jsonString = _prefs.getString(_keyVisibleCategories);
    if (jsonString == null) {
      return const FeedingTableSettings();
    }

    try {
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      final categories = decoded
          .map((e) => FeedingTableCategory.values.firstWhere(
                (c) => c.name == e,
                orElse: () => FeedingTableCategory.nursing,
              ))
          .whereType<FeedingTableCategory>()
          .toList();

      // 空の場合はデフォルト値を返す
      if (categories.isEmpty) {
        return const FeedingTableSettings();
      }

      return FeedingTableSettings(visibleCategories: categories);
    } catch (_) {
      return const FeedingTableSettings();
    }
  }

  @override
  Future<void> saveSettings(FeedingTableSettings settings) async {
    final categoryNames =
        settings.visibleCategories.map((c) => c.name).toList();
    await _prefs.setString(_keyVisibleCategories, jsonEncode(categoryNames));
    _settingsController.add(settings);
  }

  @override
  Stream<FeedingTableSettings> watchSettings() {
    getSettings().then((settings) {
      if (!_settingsController.isClosed) {
        _settingsController.add(settings);
      }
    });
    return _settingsController.stream;
  }

  void dispose() {
    _settingsController.close();
  }
}

@Riverpod(keepAlive: true)
FeedingTableSettingsRepository feedingTableSettingsRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return FeedingTableSettingsRepositoryImpl(prefs);
}
