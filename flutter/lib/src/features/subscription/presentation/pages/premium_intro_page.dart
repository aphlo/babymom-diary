import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../viewmodels/paywall_view_model.dart';

/// プレミアムプラン紹介ページ（1画面目）
/// 特典紹介 + CTAボタン → プラン選択画面へ遷移
class PremiumIntroPage extends ConsumerWidget {
  const PremiumIntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paywallViewModelProvider);

    // トライアル対象かどうか
    final bool hasFreeTrial;
    final String? monthlyPrice;

    if (state.isFallbackMode) {
      // フォールバック時はトライアルありと仮定、ハードコード価格を使用
      hasFreeTrial = true;
      monthlyPrice = '¥200';
    } else {
      hasFreeTrial = state.availablePackages.any(
        (p) =>
            p.storeProduct.introductoryPrice != null &&
            p.storeProduct.introductoryPrice!.price == 0,
      );
      final monthlyPackage = state.availablePackages
          .where((p) => p.storeProduct.identifier.contains('monthly'))
          .firstOrNull;
      monthlyPrice = monthlyPackage?.storeProduct.priceString;
    }

    return Scaffold(
      backgroundColor: context.surfaceBackground,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // ヘッダー
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    // 特典リスト
                    _buildBenefits(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // 固定フッター: CTAボタン
            _buildBottomCta(context, hasFreeTrial, monthlyPrice),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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

  Widget _buildBenefits(BuildContext context) {
    const benefits = [
      _BenefitItem(
        icon: Icons.block,
        title: '広告を完全削除',
        description: 'すべてのバナー広告が非表示になります',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.menuSectionBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.menuSectionBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'プレミアムでできること',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ...benefits.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: context.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        b.icon,
                        size: 20,
                        color: context.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: context.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            b.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCta(
    BuildContext context,
    bool hasFreeTrial,
    String? monthlyPrice,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      decoration: BoxDecoration(
        color: context.surfaceBackground,
        border: Border(
          top: BorderSide(
            color: context.menuSectionBorder,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () => context.pushNamed('paywall'),
              style: FilledButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: context.onPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                hasFreeTrial ? '無料トライアル' : 'プレミアムプランを試す',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasFreeTrial && monthlyPrice != null
                ? '1週間無料でお試し。その後$monthlyPrice/月〜。'
                : '',
            style: TextStyle(
              fontSize: 12,
              color: context.subtextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitItem {
  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
