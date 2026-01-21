import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/sale_providers.dart';
import '../../domain/entities/sale_info.dart';

/// セール情報を表示するバナー
class SaleBanner extends ConsumerWidget {
  const SaleBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleInfo = ref.watch(subscriptionSaleInfoProvider);

    if (!saleInfo.isActive) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade400,
            Colors.red.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  saleInfo.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (saleInfo.daysRemaining != null) ...[
            const SizedBox(height: 4),
            Text(
              '残り${saleInfo.daysRemaining}日',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
