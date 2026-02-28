import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../domain/entities/subscription_plan.dart';

class PaywallPlanCard extends StatelessWidget {
  const PaywallPlanCard({
    super.key,
    required this.plan,
    required this.package,
    required this.isSelected,
    required this.isRecommended,
    required this.onTap,
  });

  final SubscriptionPlan plan;
  final Package? package;
  final bool isSelected;
  final bool isRecommended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAvailable = package != null;

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.primaryColor.withValues(alpha: 0.08)
              : context.menuSectionBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.menuSectionBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Opacity(
          opacity: isAvailable ? 1.0 : 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isRecommended)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'おすすめ',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              Icon(
                _iconForPlan(plan),
                size: 28,
                color: isSelected
                    ? context.primaryColor
                    : context.textSecondary,
              ),
              const SizedBox(height: 8),
              Text(
                _labelForPlan(plan),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                package?.storeProduct.priceString ?? '-',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? context.primaryColor
                      : context.textPrimary,
                ),
              ),
              Text(
                _periodForPlan(plan),
                style: TextStyle(
                  fontSize: 11,
                  color: context.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _iconForPlan(SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.monthly => Icons.calendar_month,
      SubscriptionPlan.yearly => Icons.star,
    };
  }

  static String _labelForPlan(SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.monthly => '月額',
      SubscriptionPlan.yearly => '年額',
    };
  }

  static String _periodForPlan(SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.monthly => '/ 月',
      SubscriptionPlan.yearly => '/ 年',
    };
  }
}
