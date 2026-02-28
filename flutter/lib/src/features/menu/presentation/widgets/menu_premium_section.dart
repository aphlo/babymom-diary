import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../subscription/application/providers/subscription_providers.dart';
import 'menu_section.dart';

class MenuPremiumSection extends ConsumerWidget {
  const MenuPremiumSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'プレミアム',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.subtextColor,
              ),
            ),
          ),
        ),
        MenuSection(
          children: [
            ListTile(
              leading: Icon(
                Icons.workspace_premium_outlined,
                color: isPremium ? context.textSecondary : context.primaryColor,
              ),
              title: Text(isPremium ? 'プレミアム加入中' : 'プレミアムプラン'),
              trailing: isPremium ? null : const Icon(Icons.chevron_right),
              enabled: !isPremium,
              onTap: isPremium ? null : () => context.pushNamed('paywall'),
            ),
          ],
        ),
      ],
    );
  }
}
