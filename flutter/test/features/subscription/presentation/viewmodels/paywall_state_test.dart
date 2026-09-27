import 'package:babymom_diary/src/features/subscription/domain/entities/subscription_plan.dart';
import 'package:babymom_diary/src/features/subscription/presentation/viewmodels/paywall_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaywallState', () {
    test('initial state has lifetime plan and empty packages', () {
      final state = PaywallState.initial();

      expect(state.selectedPlan, SubscriptionPlan.lifetime);
      expect(state.availablePackages, isEmpty);
      expect(state.isLoadingOfferings, isTrue);
      expect(state.isPurchasing, isFalse);
      expect(state.isRestoring, isFalse);
      expect(state.isFallbackMode, isFalse);
      expect(state.canPurchase, isFalse);
      expect(state.adFreePackage, isNull);
    });

    test(
        'canPurchase is true when isFallbackMode is true and not loading/purchasing',
        () {
      final state = PaywallState.initial().copyWith(
        isLoadingOfferings: false,
        isFallbackMode: true,
      );

      expect(state.canPurchase, isTrue);
    });

    test('canPurchase is false during purchasing or restoring', () {
      final state = PaywallState.initial().copyWith(
        isLoadingOfferings: false,
        isFallbackMode: true,
        isPurchasing: true,
      );
      expect(state.canPurchase, isFalse);

      final stateRestoring = PaywallState.initial().copyWith(
        isLoadingOfferings: false,
        isFallbackMode: true,
        isRestoring: true,
      );
      expect(stateRestoring.canPurchase, isFalse);
    });
  });
}
