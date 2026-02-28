import 'package:flutter/material.dart';

import '../../../../core/theme/semantic_colors.dart';

class PaywallHeader extends StatelessWidget {
  const PaywallHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/icons/milu_bear.png',
                width: 64,
                height: 64,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'milu プレミアム',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '広告なしで快適に。もっと便利に。',
            style: TextStyle(
              fontSize: 15,
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
