import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../preferences/shared_preferences_provider.dart';
import 'theme_mode_storage.dart';

part 'theme_mode_provider.g.dart';

/// ThemeModeStorageのProvider
@riverpod
ThemeModeStorage themeModeStorage(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeStorage(prefs);
}

/// テーマモードの状態管理Notifier
@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final storage = ref.watch(themeModeStorageProvider);
    return storage.getThemeMode();
  }

  /// テーマモードを変更
  Future<void> setThemeMode(ThemeMode mode) async {
    final storage = ref.read(themeModeStorageProvider);
    await storage.setThemeMode(mode);
    state = mode;
  }
}
