import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_view_model.dart';

void main() {
  group('AddCalendarEventViewModel', () {
    late AddCalendarEventViewModel viewModel;

    setUp(() {
      viewModel = AddCalendarEventViewModel(
        initialDate: DateTime(2024, 3, 15),
      );
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('初期状態が正しい', () {
      final state = viewModel.state;
      expect(state.title, '');
      expect(state.memo, '');
      expect(state.allDay, false);
      expect(state.startDate, DateTime(2024, 3, 15));
      expect(state.endDate, DateTime(2024, 3, 15));
      expect(state.startTime, const TimeOfDay(hour: 9, minute: 0));
      expect(state.endTime, const TimeOfDay(hour: 10, minute: 0));
      expect(state.selectedIconPath, '');
      expect(state.isSubmitting, false);
      expect(state.titleError, isNull);
      expect(state.dateTimeError, isNull);
      expect(state.availableIconPaths.isNotEmpty, true);
    });

    test('updateTitle でタイトルを更新', () {
      viewModel.updateTitle('テストイベント');
      expect(viewModel.state.title, 'テストイベント');
    });

    test('updateTitle でtitleErrorがクリアされる', () {
      // まずエラーを設定
      viewModel.buildResult(); // タイトル空でエラーが設定される
      expect(viewModel.state.titleError, isNotNull);

      // タイトル更新でエラークリア
      viewModel.updateTitle('タイトル');
      expect(viewModel.state.titleError, isNull);
    });

    test('updateMemo でメモを更新', () {
      viewModel.updateMemo('メモ内容');
      expect(viewModel.state.memo, 'メモ内容');
    });

    test('updateAllDay で終日フラグを更新', () {
      viewModel.updateAllDay(true);
      expect(viewModel.state.allDay, true);
    });

    test('updateStartDate で開始日を更新', () {
      final newDate = DateTime(2024, 4, 1);
      viewModel.updateStartDate(newDate);
      expect(viewModel.state.startDate, newDate);
    });

    test('updateEndDate で終了日を更新', () {
      final newDate = DateTime(2024, 4, 5);
      viewModel.updateEndDate(newDate);
      expect(viewModel.state.endDate, newDate);
    });

    test('updateStartTime で開始時刻を更新', () {
      const newTime = TimeOfDay(hour: 14, minute: 30);
      viewModel.updateStartTime(newTime);
      expect(viewModel.state.startTime, newTime);
    });

    test('updateEndTime で終了時刻を更新', () {
      const newTime = TimeOfDay(hour: 17, minute: 0);
      viewModel.updateEndTime(newTime);
      expect(viewModel.state.endTime, newTime);
    });

    test('selectIcon でアイコンを選択', () {
      viewModel.selectIcon('assets/icons/birthday.png');
      expect(viewModel.state.selectedIconPath, 'assets/icons/birthday.png');
    });

    group('buildResult', () {
      test('タイトルが空の場合はnullを返しエラーを設定', () {
        final result = viewModel.buildResult();
        expect(result, isNull);
        expect(viewModel.state.titleError, 'タイトルを入力してください');
      });

      test('終了時刻が開始時刻より前の場合はnullを返しエラーを設定', () {
        viewModel.updateTitle('テストイベント');
        viewModel.updateEndTime(const TimeOfDay(hour: 8, minute: 0));

        final result = viewModel.buildResult();
        expect(result, isNull);
        expect(viewModel.state.dateTimeError, '終了時間は開始時間より後にしてください');
      });

      test('有効な入力の場合はCalendarEventModelを返す', () {
        viewModel.updateTitle('テストイベント');
        viewModel.updateMemo('メモ');
        viewModel.updateAllDay(true);
        viewModel.selectIcon('assets/icons/birthday.png');

        final result = viewModel.buildResult();
        expect(result, isNotNull);
        expect(result!.title, 'テストイベント');
        expect(result.memo, 'メモ');
        expect(result.allDay, true);
        expect(result.iconPath, 'assets/icons/birthday.png');
      });

      test('タイトルの前後の空白はトリムされる', () {
        viewModel.updateTitle('  テスト  ');
        viewModel.updateMemo('  メモ  ');

        final result = viewModel.buildResult();
        expect(result, isNotNull);
        expect(result!.title, 'テスト');
        expect(result.memo, 'メモ');
      });
    });
  });
}
