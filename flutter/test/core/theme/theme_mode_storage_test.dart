import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/core/theme/theme_mode_storage.dart';

void main() {
  group('ThemeModeStorage', () {
    late SharedPreferences prefs;
    late ThemeModeStorage storage;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      storage = ThemeModeStorage(prefs);
    });

    group('getThemeMode', () {
      test('未設定の場合はThemeMode.systemを返す', () {
        final result = storage.getThemeMode();

        expect(result, ThemeMode.system);
      });

      test('lightが保存されている場合はThemeMode.lightを返す', () async {
        SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
        prefs = await SharedPreferences.getInstance();
        storage = ThemeModeStorage(prefs);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.light);
      });

      test('darkが保存されている場合はThemeMode.darkを返す', () async {
        SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
        prefs = await SharedPreferences.getInstance();
        storage = ThemeModeStorage(prefs);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.dark);
      });

      test('systemが保存されている場合はThemeMode.systemを返す', () async {
        SharedPreferences.setMockInitialValues({'theme_mode': 'system'});
        prefs = await SharedPreferences.getInstance();
        storage = ThemeModeStorage(prefs);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.system);
      });

      test('不正な値が保存されている場合はThemeMode.systemを返す', () async {
        SharedPreferences.setMockInitialValues({'theme_mode': 'invalid'});
        prefs = await SharedPreferences.getInstance();
        storage = ThemeModeStorage(prefs);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.system);
      });
    });

    group('setThemeMode', () {
      test('ThemeMode.lightを保存できる', () async {
        await storage.setThemeMode(ThemeMode.light);

        expect(prefs.getString('theme_mode'), 'light');
      });

      test('ThemeMode.darkを保存できる', () async {
        await storage.setThemeMode(ThemeMode.dark);

        expect(prefs.getString('theme_mode'), 'dark');
      });

      test('ThemeMode.systemを保存できる', () async {
        await storage.setThemeMode(ThemeMode.system);

        expect(prefs.getString('theme_mode'), 'system');
      });
    });

    group('round-trip', () {
      test('lightを保存して読み込むとlightが返る', () async {
        await storage.setThemeMode(ThemeMode.light);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.light);
      });

      test('darkを保存して読み込むとdarkが返る', () async {
        await storage.setThemeMode(ThemeMode.dark);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.dark);
      });

      test('systemを保存して読み込むとsystemが返る', () async {
        await storage.setThemeMode(ThemeMode.system);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.system);
      });

      test('複数回変更しても最後の値が保持される', () async {
        await storage.setThemeMode(ThemeMode.light);
        await storage.setThemeMode(ThemeMode.dark);
        await storage.setThemeMode(ThemeMode.system);
        await storage.setThemeMode(ThemeMode.dark);

        final result = storage.getThemeMode();

        expect(result, ThemeMode.dark);
      });
    });
  });
}
