import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../subscription/application/providers/subscription_providers.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF3A0B1), // 優美なローズゴールド
                    Color(0xFFFFD56B), // シャンパンゴールド
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: const Color(0xFFFFF6D6).withValues(alpha: 0.8),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF3A0B1).withValues(alpha: 0.35),
                    blurRadius: 12,
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
                  leading: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Icon(
                        Icons.workspace_premium,
                        color: Color(0xFFD84B6B), // ローズゴールド調に調和させたピンク
                        size: 26,
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      const Text(
                        'プレミアムメンバー',
                        style: TextStyle(
                          color: Color(0xFF4E2C33), // 深みのある色合いで可読性を担保
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.auto_awesome,
                        color: const Color(0xFFE65100).withValues(alpha: 0.7),
                        size: 14,
                      ),
                    ],
                  ),
                  subtitle: const Text(
                    'いつもご利用ありがとうございます！',
                    style: TextStyle(
                      color: Color(0xFF6B4A51),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
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
                  size: 24,
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
