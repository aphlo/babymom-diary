import 'package:flutter/material.dart';

import '../../domain/entities/subscription_plan.dart';
import '../viewmodels/paywall_state.dart';
import 'paywall_plan_card.dart';

class PaywallPlanSelector extends StatelessWidget {
  const PaywallPlanSelector({
    super.key,
    required this.state,
    required this.onSelectPlan,
  });

  final PaywallState state;
  final ValueChanged<SubscriptionPlan> onSelectPlan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: PaywallPlanCard(
              plan: SubscriptionPlan.monthly,
              package: state.packageForPlan(SubscriptionPlan.monthly),
              isSelected: state.selectedPlan == SubscriptionPlan.monthly,
              isRecommended: false,
              onTap: () => onSelectPlan(SubscriptionPlan.monthly),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PaywallPlanCard(
              plan: SubscriptionPlan.yearly,
              package: state.packageForPlan(SubscriptionPlan.yearly),
              isSelected: state.selectedPlan == SubscriptionPlan.yearly,
              isRecommended: true,
              onTap: () => onSelectPlan(SubscriptionPlan.yearly),
            ),
          ),
        ],
      ),
    );
  }
}
