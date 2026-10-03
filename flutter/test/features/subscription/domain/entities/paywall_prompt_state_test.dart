import 'package:flutter_test/flutter_test.dart';
import 'package:babymom_diary/src/features/subscription/domain/entities/paywall_prompt_state.dart';

void main() {
  group('PaywallPromptState', () {
    final now = DateTime(2026, 10, 3, 12, 0);

    test('初期状態では正しくデフォルト値が設定されている', () {
      const state = PaywallPromptState.initial;
      expect(state.lastShownDate, isNull);
      expect(state.hasShownOnboarding, isFalse);
      expect(state.lastShownMilestoneRecordCount, equals(0));
    });

    group('isSuppressed', () {
      test('プレミアムユーザーは常に抑制される', () {
        const state = PaywallPromptState.initial;
        expect(state.isSuppressed(now: now, isPremium: true), isTrue);
      });

      test('今日すでにレビューダイアログが表示されていたら抑制される', () {
        const state = PaywallPromptState.initial;
        expect(
          state.isSuppressed(
            now: now,
            isPremium: false,
            reviewLastShownDate: '2026-10-03',
          ),
          isTrue,
        );
      });

      test('前日にレビューダイアログが表示されただけなら抑制されない', () {
        const state = PaywallPromptState.initial;
        expect(
          state.isSuppressed(
            now: now,
            isPremium: false,
            reviewLastShownDate: '2026-10-02',
          ),
          isFalse,
        );
      });

      test('今日すでにPaywallが表示されていたら抑制される', () {
        const state = PaywallPromptState(lastShownDate: '2026-10-03');
        expect(state.isSuppressed(now: now, isPremium: false), isTrue);
      });

      test('クールダウン期間（7日未満、例: 5日前）なら抑制される', () {
        const state = PaywallPromptState(lastShownDate: '2026-09-28');
        expect(state.isSuppressed(now: now, isPremium: false), isTrue);
      });

      test('クールダウン期間（7日以上前、例: 8日前）なら抑制されない', () {
        const state = PaywallPromptState(lastShownDate: '2026-09-25');
        expect(state.isSuppressed(now: now, isPremium: false), isFalse);
      });
    });

    group('shouldShowOnboarding', () {
      test('オンボーディング未表示かつ未抑制なら表示する', () {
        const state = PaywallPromptState.initial;
        expect(state.shouldShowOnboarding(now: now, isPremium: false), isTrue);
      });

      test('オンボーディング表示済みなら表示しない', () {
        const state = PaywallPromptState(hasShownOnboarding: true);
        expect(state.shouldShowOnboarding(now: now, isPremium: false), isFalse);
      });

      test('プレミアムユーザーならオンボーディング時も表示しない', () {
        const state = PaywallPromptState.initial;
        expect(state.shouldShowOnboarding(now: now, isPremium: true), isFalse);
      });
    });

    group('shouldShowForRecordCount', () {
      test('マイルストーン（10, 30, 50）達成時に表示する', () {
        const state = PaywallPromptState.initial;
        expect(
          state.shouldShowForRecordCount(
            recordCount: 10,
            now: now,
            isPremium: false,
          ),
          isTrue,
        );
        expect(
          state.shouldShowForRecordCount(
            recordCount: 30,
            now: now,
            isPremium: false,
          ),
          isTrue,
        );
        expect(
          state.shouldShowForRecordCount(
            recordCount: 50,
            now: now,
            isPremium: false,
          ),
          isTrue,
        );
      });

      test('マイルストーン以外の回数（例: 9, 11, 25）では表示しない', () {
        const state = PaywallPromptState.initial;
        expect(
          state.shouldShowForRecordCount(
            recordCount: 9,
            now: now,
            isPremium: false,
          ),
          isFalse,
        );
        expect(
          state.shouldShowForRecordCount(
            recordCount: 11,
            now: now,
            isPremium: false,
          ),
          isFalse,
        );
        expect(
          state.shouldShowForRecordCount(
            recordCount: 25,
            now: now,
            isPremium: false,
          ),
          isFalse,
        );
      });

      test('すでにそのマイルストーン以下で表示済みなら再表示しない', () {
        const state = PaywallPromptState(
          lastShownMilestoneRecordCount: 10,
          lastShownDate: '2026-09-01', // クールダウンは経過済み
        );
        expect(
          state.shouldShowForRecordCount(
            recordCount: 10,
            now: now,
            isPremium: false,
          ),
          isFalse,
        );
        // 次のマイルストーン30なら表示可能
        expect(
          state.shouldShowForRecordCount(
            recordCount: 30,
            now: now,
            isPremium: false,
          ),
          isTrue,
        );
      });

      test('クールダウン期間中はマイルストーンに達していても表示しない', () {
        const state = PaywallPromptState(
          lastShownDate: '2026-10-01', // 2日前
          lastShownMilestoneRecordCount: 0,
        );
        expect(
          state.shouldShowForRecordCount(
            recordCount: 10,
            now: now,
            isPremium: false,
          ),
          isFalse,
        );
      });
    });
  });
}
