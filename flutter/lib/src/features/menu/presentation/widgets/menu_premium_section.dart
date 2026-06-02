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

    Widget buildHeader() {
      return Padding(
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
      );
    }

    if (isPremium) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          MenuSection(
            children: [
              ListTile(
                leading: Icon(
                  Icons.workspace_premium,
                  color: context.textSecondary,
                ),
                title: const Text('プレミアム加入中'),
                enabled: false,
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFFE87086), Color(0xFFFFA726)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE87086).withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                leading: const Icon(
                  Icons.workspace_premium,
                  color: Color(0xFFFFD700), // ゴールド王冠
                  size: 28,
                ),
                title: const Text(
                  'プレミアムプラン',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '広告なしで快適に。もっと便利に。',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.white70,
                ),
                onTap: () => context.pushNamed('premium_intro'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
