import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/core/preferences/shared_preferences_provider.dart';
import 'package:babymom_diary/src/core/theme/theme_mode_provider.dart';

void main() {
  group('ThemeModeNotifier', () {
    late ProviderContainer container;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態でThemeMode.systemを返す', () {
      final themeMode = container.read(themeModeProvider);

      expect(themeMode, ThemeMode.system);
    });

    test('保存されたlightを初期値として読み込む', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
      prefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );

      final themeMode = container.read(themeModeProvider);

      expect(themeMode, ThemeMode.light);
    });

    test('保存されたdarkを初期値として読み込む', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
      prefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );

      final themeMode = container.read(themeModeProvider);

      expect(themeMode, ThemeMode.dark);
    });

    group('setThemeMode', () {
      test('ThemeMode.lightに変更できる', () async {
        final notifier = container.read(themeModeProvider.notifier);

        await notifier.setThemeMode(ThemeMode.light);

        expect(container.read(themeModeProvider), ThemeMode.light);
      });

      test('ThemeMode.darkに変更できる', () async {
        final notifier = container.read(themeModeProvider.notifier);

        await notifier.setThemeMode(ThemeMode.dark);

        expect(container.read(themeModeProvider), ThemeMode.dark);
      });

      test('ThemeMode.systemに変更できる', () async {
        final notifier = container.read(themeModeProvider.notifier);
        await notifier.setThemeMode(ThemeMode.dark);

        await notifier.setThemeMode(ThemeMode.system);

        expect(container.read(themeModeProvider), ThemeMode.system);
      });

      test('変更がSharedPreferencesに永続化される', () async {
        final notifier = container.read(themeModeProvider.notifier);

        await notifier.setThemeMode(ThemeMode.dark);

        expect(prefs.getString('theme_mode'), 'dark');
      });

      test('永続化された値が新しいProviderContainerで復元される', () async {
        final notifier = container.read(themeModeProvider.notifier);
        await notifier.setThemeMode(ThemeMode.dark);

        // 新しいProviderContainerを作成（アプリ再起動をシミュレート）
        final newContainer = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
        );
        addTearDown(newContainer.dispose);

        final restoredThemeMode = newContainer.read(themeModeProvider);

        expect(restoredThemeMode, ThemeMode.dark);
      });
    });
  });
}
