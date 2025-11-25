import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_settings_repository.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_settings_view_model.dart';

class MockCalendarSettingsRepository extends Mock
    implements CalendarSettingsRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(const CalendarSettings(startingDayOfWeek: false));
  });
  group('CalendarSettingsState', () {
    test('初期状態が正しい', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      expect(state.settings.startingDayOfWeek, false);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('copyWith で settings を更新できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      final newState = state.copyWith(
        settings: const CalendarSettings(startingDayOfWeek: true),
      );

      expect(newState.settings.startingDayOfWeek, true);
      expect(newState.isLoading, false);
    });

    test('copyWith で isLoading を更新できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      final newState = state.copyWith(isLoading: true);

      expect(newState.isLoading, true);
      expect(newState.settings.startingDayOfWeek, false);
    });

    test('copyWith で error を更新できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      final newState = state.copyWith(error: 'エラーメッセージ');

      expect(newState.error, 'エラーメッセージ');
    });

    test('copyWith で error を null に設定できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
        error: 'エラー',
      );

      final newState = state.copyWith(error: null);

      expect(newState.error, isNull);
    });
  });

  group('CalendarSettingsViewModel', () {
    late MockCalendarSettingsRepository mockRepository;

    setUp(() {
      mockRepository = MockCalendarSettingsRepository();
    });

    test('初期化時に設定を読み込む', () async {
      when(() => mockRepository.getSettings()).thenAnswer(
        (_) async => const CalendarSettings(startingDayOfWeek: true),
      );

      final viewModel = CalendarSettingsViewModel(mockRepository);

      // 初期状態
      expect(viewModel.state.settings.startingDayOfWeek, false);

      // 非同期読み込み完了を待つ
      await Future.delayed(Duration.zero);

      expect(viewModel.state.settings.startingDayOfWeek, true);
      expect(viewModel.state.isLoading, false);
      verify(() => mockRepository.getSettings()).called(1);

      viewModel.dispose();
    });

    test('設定読み込み失敗時にエラーを設定', () async {
      when(() => mockRepository.getSettings()).thenThrow(Exception('読み込みエラー'));

      final viewModel = CalendarSettingsViewModel(mockRepository);

      // 非同期処理完了を待つ
      await Future.delayed(Duration.zero);

      expect(viewModel.state.error, contains('設定の読み込みに失敗しました'));
      expect(viewModel.state.isLoading, false);

      viewModel.dispose();
    });

    test('updateStartingDayOfWeek で設定を更新', () async {
      when(() => mockRepository.getSettings()).thenAnswer(
        (_) async => const CalendarSettings(startingDayOfWeek: false),
      );
      when(() => mockRepository.saveSettings(any())).thenAnswer((_) async {});

      final viewModel = CalendarSettingsViewModel(mockRepository);
      await Future.delayed(Duration.zero);

      await viewModel.updateStartingDayOfWeek(true);

      expect(viewModel.state.settings.startingDayOfWeek, true);
      expect(viewModel.state.isLoading, false);

      verify(() => mockRepository.saveSettings(
            const CalendarSettings(startingDayOfWeek: true),
          )).called(1);

      viewModel.dispose();
    });

    test('updateStartingDayOfWeek で保存失敗時にエラーを設定', () async {
      when(() => mockRepository.getSettings()).thenAnswer(
        (_) async => const CalendarSettings(startingDayOfWeek: false),
      );
      when(() => mockRepository.saveSettings(any()))
          .thenThrow(Exception('保存エラー'));

      final viewModel = CalendarSettingsViewModel(mockRepository);
      await Future.delayed(Duration.zero);

      await viewModel.updateStartingDayOfWeek(true);

      expect(viewModel.state.error, contains('設定の保存に失敗しました'));
      expect(viewModel.state.isLoading, false);

      viewModel.dispose();
    });
  });
}
