import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_settings.dart';
import 'package:babymom_diary/src/features/vaccines/infrastructure/repositories/vaccine_settings_repository_impl.dart';

void main() {
  group('VaccineSettingsRepositoryImpl', () {
    late SharedPreferences prefs;
    late VaccineSettingsRepositoryImpl repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      repository = VaccineSettingsRepositoryImpl(prefs);
    });

    tearDown(() {
      repository.dispose();
    });

    group('getSettings', () {
      test('初期状態でVaccineViewMode.tableがデフォルト', () async {
        final settings = await repository.getSettings();

        expect(settings.viewMode, VaccineViewMode.table);
      });

      test('保存された値を正しく読み込む（table）', () async {
        SharedPreferences.setMockInitialValues({
          'vaccine_view_mode': VaccineViewMode.table.index,
        });
        prefs = await SharedPreferences.getInstance();
        repository = VaccineSettingsRepositoryImpl(prefs);

        final settings = await repository.getSettings();

        expect(settings.viewMode, VaccineViewMode.table);
      });

      test('保存された値を正しく読み込む（list）', () async {
        SharedPreferences.setMockInitialValues({
          'vaccine_view_mode': VaccineViewMode.list.index,
        });
        prefs = await SharedPreferences.getInstance();
        repository = VaccineSettingsRepositoryImpl(prefs);

        final settings = await repository.getSettings();

        expect(settings.viewMode, VaccineViewMode.list);
      });
    });

    group('saveSettings', () {
      test('設定を保存できる', () async {
        const settings = VaccineSettings(viewMode: VaccineViewMode.list);

        await repository.saveSettings(settings);

        final savedIndex = prefs.getInt('vaccine_view_mode');
        expect(savedIndex, VaccineViewMode.list.index);
      });

      test('保存後に読み込むと保存した値が取得できる', () async {
        const settings = VaccineSettings(viewMode: VaccineViewMode.list);

        await repository.saveSettings(settings);
        final loadedSettings = await repository.getSettings();

        expect(loadedSettings.viewMode, VaccineViewMode.list);
      });
    });

    group('watchSettings', () {
      test('ストリームが初期値を発行する', () async {
        final stream = repository.watchSettings();

        final settings = await stream.first;

        expect(settings.viewMode, VaccineViewMode.table);
      });

      test('保存時にストリームに新しい値が発行される', () async {
        final stream = repository.watchSettings();
        const newSettings = VaccineSettings(viewMode: VaccineViewMode.list);

        // 初期値をスキップ
        await stream.first;

        // 保存後の値を確認
        final future = stream.first;
        await repository.saveSettings(newSettings);
        final emittedSettings = await future;

        expect(emittedSettings.viewMode, VaccineViewMode.list);
      });
    });
  });
}
