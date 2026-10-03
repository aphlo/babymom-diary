import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babymom_diary/src/features/subscription/infrastructure/repositories/paywall_prompt_repository_impl.dart';
import 'package:babymom_diary/src/features/subscription/application/usecases/check_paywall_prompt_onboarding.dart';
import 'package:babymom_diary/src/features/subscription/application/usecases/check_paywall_prompt_record.dart';
import 'package:babymom_diary/src/features/subscription/application/usecases/record_paywall_prompt_shown.dart';

void main() {
  group('PaywallPrompt UseCases & Repository', () {
    late SharedPreferences prefs;
    late PaywallPromptRepositoryImpl repository;
    final now = DateTime(2026, 10, 3, 12, 0);

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      repository = PaywallPromptRepositoryImpl(prefs);
    });

    test('オンボーディング判定UseCase: 初回は表示、記録後は表示されない', () async {
      final checkUseCase = CheckPaywallPromptOnboarding(repository);
      final recordShownUseCase = RecordPaywallPromptShown(repository);

      // 初回はtrue
      final shouldShow1 = await checkUseCase(now: now, isPremium: false);
      expect(shouldShow1, isTrue);

      // 表示を記録
      await recordShownUseCase(now: now, isOnboarding: true);

      // 記録後はfalse
      final shouldShow2 = await checkUseCase(now: now, isPremium: false);
      expect(shouldShow2, isFalse);

      final state = await repository.getState();
      expect(state.hasShownOnboarding, isTrue);
      expect(state.lastShownDate, equals('2026-10-03'));
    });

    test('記録マイルストーン判定UseCase: 10回達成で表示、記録後は次回マイルストーンまで表示されない', () async {
      final checkUseCase = CheckPaywallPromptRecord(repository);
      final recordShownUseCase = RecordPaywallPromptShown(repository);

      // 10回到達時: true
      final shouldShow10 = await checkUseCase(
        recordCount: 10,
        now: now,
        isPremium: false,
      );
      expect(shouldShow10, isTrue);

      // 表示を記録（10回）
      await recordShownUseCase(now: now, milestoneRecordCount: 10);

      // 同じ日・同じカウントではfalse
      final shouldShowSame = await checkUseCase(
        recordCount: 10,
        now: now,
        isPremium: false,
      );
      expect(shouldShowSame, isFalse);

      // 8日後（クールダウン経過）でも同じ10回ならfalse
      final futureDate = now.add(const Duration(days: 8));
      final shouldShowAfterCooldown = await checkUseCase(
        recordCount: 10,
        now: futureDate,
        isPremium: false,
      );
      expect(shouldShowAfterCooldown, isFalse);

      // 8日後かつマイルストーン30回ならtrue
      final shouldShow30 = await checkUseCase(
        recordCount: 30,
        now: futureDate,
        isPremium: false,
      );
      expect(shouldShow30, isTrue);
    });
  });
}
