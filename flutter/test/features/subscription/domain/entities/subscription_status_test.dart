import 'package:babymom_diary/src/features/subscription/domain/entities/subscription_plan.dart';
import 'package:babymom_diary/src/features/subscription/domain/entities/subscription_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubscriptionStatus', () {
    test('free status has isPremium as false', () {
      const status = SubscriptionStatus.free;
      expect(status.isPremium, isFalse);
      expect(status.activePlan, isNull);
      expect(status.expiresAt, isNull);
    });

    test('premium status holds lifetime plan', () {
      const status = SubscriptionStatus(
        isPremium: true,
        activePlan: SubscriptionPlan.lifetime,
      );
      expect(status.isPremium, isTrue);
      expect(status.activePlan, SubscriptionPlan.lifetime);
      expect(status.expiresAt, isNull);
    });

    test('equality and hashCode work as expected', () {
      const status1 = SubscriptionStatus(
        isPremium: true,
        activePlan: SubscriptionPlan.lifetime,
      );
      const status2 = SubscriptionStatus(
        isPremium: true,
        activePlan: SubscriptionPlan.lifetime,
      );
      const status3 = SubscriptionStatus(
        isPremium: false,
      );

      expect(status1, equals(status2));
      expect(status1.hashCode, equals(status2.hashCode));
      expect(status1, isNot(equals(status3)));
    });
  });

  group('SubscriptionPlan', () {
    test('contains lifetime plan', () {
      expect(SubscriptionPlan.values, contains(SubscriptionPlan.lifetime));
    });
  });
}
