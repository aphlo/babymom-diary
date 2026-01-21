import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/features/subscription/application/providers/subscription_providers.dart';

import 'menu_section.dart';

/// メニューのプレミアムセクション
class MenuPremiumSection extends ConsumerWidget {
  const MenuPremiumSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubscribed = ref.watch(isSubscriptionActiveProvider);

    return MenuSection(
      children: [
        ListTile(
          leading: Icon(
            Icons.star,
            color: isSubscribed
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          title: const Text('プレミアムプラン'),
          subtitle: Text(
            isSubscribed ? '加入中 - 広告非表示' : '広告を非表示にする',
          ),
          onTap: () => context.push('/subscription'),
          trailing: isSubscribed
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                )
              : const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
