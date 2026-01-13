import 'package:babymom_diary/src/features/review_prompt/domain/entities/review_prompt_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReviewPromptState.shouldShowDialog', () {
    final now = DateTime(2026, 1, 13, 12, 0, 0);
    final today = '2026-01-13';
    final yesterday = '2026-01-12';

    group('抑制条件', () {
      test('レビュー済みの場合は表示しない', () {
        final state = ReviewPromptState(
          recordCount: 5,
          appLaunchCount: 5,
          hasReviewed: true,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isFalse);
      });

      test('本日すでに表示済みの場合は表示しない', () {
        final state = ReviewPromptState(
          recordCount: 5,
          appLaunchCount: 5,
          hasReviewed: false,
          lastShownDate: today,
        );
        expect(state.shouldShowDialog(now: now), isFalse);
      });

      test('昨日表示済みの場合は表示可能', () {
        final state = ReviewPromptState(
          recordCount: 5,
          appLaunchCount: 5,
          hasReviewed: false,
          lastShownDate: yesterday,
        );
        expect(state.shouldShowDialog(now: now), isTrue);
      });
    });

    group('条件A: 記録回数がちょうど3回', () {
      test('記録回数が3回ちょうどなら表示する', () {
        final state = ReviewPromptState(
          recordCount: 3,
          appLaunchCount: 0,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isTrue);
      });

      test('記録回数が2回では表示しない（条件Bも満たさない場合）', () {
        final state = ReviewPromptState(
          recordCount: 2,
          appLaunchCount: 1,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isFalse);
      });

      test('記録回数が4回では条件Aは満たさない', () {
        // 条件Bも満たさない場合
        final state = ReviewPromptState(
          recordCount: 4,
          appLaunchCount: 2,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isFalse);
      });
    });

    group('条件B: 起動3回以上 かつ 記録1回以上', () {
      test('起動3回、記録1回で表示する', () {
        final state = ReviewPromptState(
          recordCount: 1,
          appLaunchCount: 3,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isTrue);
      });

      test('起動5回、記録2回で表示する', () {
        final state = ReviewPromptState(
          recordCount: 2,
          appLaunchCount: 5,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isTrue);
      });

      test('起動3回、記録0回では表示しない', () {
        final state = ReviewPromptState(
          recordCount: 0,
          appLaunchCount: 3,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isFalse);
      });

      test('起動2回、記録5回では表示しない（条件Aも満たさない）', () {
        final state = ReviewPromptState(
          recordCount: 5,
          appLaunchCount: 2,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowDialog(now: now), isFalse);
      });
    });

    group('初期状態', () {
      test('initial状態では表示しない', () {
        final state = ReviewPromptState.initial();
        expect(state.shouldShowDialog(now: now), isFalse);
      });
    });
  });

  group('ReviewPromptState.shouldShowAfterRecordIncrement', () {
    final now = DateTime(2026, 1, 13, 12, 0, 0);
    final today = '2026-01-13';

    group('抑制条件', () {
      test('レビュー済みの場合は表示しない', () {
        final state = ReviewPromptState(
          recordCount: 2, // 増加後3になるが、レビュー済み
          appLaunchCount: 5,
          hasReviewed: true,
          lastShownDate: null,
        );
        expect(state.shouldShowAfterRecordIncrement(now: now), isFalse);
      });

      test('本日すでに表示済みの場合は表示しない', () {
        final state = ReviewPromptState(
          recordCount: 2, // 増加後3になるが、本日表示済み
          appLaunchCount: 5,
          hasReviewed: false,
          lastShownDate: today,
        );
        expect(state.shouldShowAfterRecordIncrement(now: now), isFalse);
      });
    });

    group('条件A: 増加後の記録回数がちょうど3回', () {
      test('現在2回 → 増加後3回で表示する', () {
        final state = ReviewPromptState(
          recordCount: 2,
          appLaunchCount: 0,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowAfterRecordIncrement(now: now), isTrue);
      });

      test('現在3回 → 増加後4回では条件Aは満たさない', () {
        // 条件Bも満たさない場合
        final state = ReviewPromptState(
          recordCount: 3,
          appLaunchCount: 2,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowAfterRecordIncrement(now: now), isFalse);
      });
    });

    group('条件B: 起動3回以上 かつ 増加後の記録が1回以上', () {
      test('起動3回、現在記録0回 → 増加後1回で表示する', () {
        final state = ReviewPromptState(
          recordCount: 0,
          appLaunchCount: 3,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowAfterRecordIncrement(now: now), isTrue);
      });

      test('起動2回、現在記録0回 → 増加後1回でも起動不足で表示しない', () {
        final state = ReviewPromptState(
          recordCount: 0,
          appLaunchCount: 2,
          hasReviewed: false,
          lastShownDate: null,
        );
        expect(state.shouldShowAfterRecordIncrement(now: now), isFalse);
      });
    });
  });
}
