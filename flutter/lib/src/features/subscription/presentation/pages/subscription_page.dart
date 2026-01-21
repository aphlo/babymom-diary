import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

import '../../application/providers/sale_providers.dart';
import '../../domain/entities/sale_info.dart';
import '../../domain/value_objects/entitlement_id.dart';
import '../../infrastructure/services/customer_center_service.dart';
import '../../infrastructure/services/paywall_service.dart';
import '../viewmodels/subscription_state.dart';
import '../viewmodels/subscription_view_model.dart';
import '../widgets/sale_banner.dart';

/// サブスクリプション購入画面
class SubscriptionPage extends ConsumerWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionViewModelProvider);
    final viewModel = ref.read(subscriptionViewModelProvider.notifier);

    // UIイベントを監視
    ref.listen<SubscriptionState>(
      subscriptionViewModelProvider,
      (previous, next) {
        final event = next.pendingUiEvent;
        if (event == null) return;

        viewModel.consumeUiEvent();

        event.when(
          showMessage: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          purchaseSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('購入が完了しました')),
            );
            context.pop();
          },
          restoreSuccess: (hasActiveSubscription) {
            if (hasActiveSubscription) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('購入を復元しました')),
              );
              context.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('復元可能な購入がありませんでした')),
              );
            }
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: const Text('プレミアムプラン'),
      ),
      body: state.isSubscribed
          ? const _SubscribedContent()
          : _PurchaseContent(state: state, viewModel: viewModel),
    );
  }
}

/// RevenueCat Paywallを使用したサブスクリプション画面
///
/// RevenueCat DashboardでPaywallをカスタマイズした場合はこちらを使用
class PaywallSubscriptionPage extends StatelessWidget {
  const PaywallSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: const Text('プレミアムプラン'),
      ),
      body: const _PaywallContent(),
    );
  }
}

/// RevenueCat Paywallを表示するコンテンツ
class _PaywallContent extends StatelessWidget {
  const _PaywallContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'プレミアムプラン',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '広告を非表示にして\n快適にアプリをお使いいただけます',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => _showPaywall(context),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('プランを見る'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _showPaywallIfNeeded(context),
              child: const Text('購入を復元'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPaywall(BuildContext context) async {
    try {
      final result = await PaywallService().presentPaywall(context: context);
      if (!context.mounted) return;

      switch (result) {
        case PaywallResult.purchased:
        case PaywallResult.restored:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('購入が完了しました')),
          );
          Navigator.of(context).pop();
          break;
        case PaywallResult.notPresented:
        case PaywallResult.error:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('購入処理中にエラーが発生しました')),
          );
          break;
        case PaywallResult.cancelled:
          // ユーザーがキャンセルした場合は何もしない
          break;
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }

  Future<void> _showPaywallIfNeeded(BuildContext context) async {
    try {
      final result = await PaywallService().presentPaywallIfNeeded(
        context: context,
        requiredEntitlementIdentifier: EntitlementId.miluPro,
      );
      if (!context.mounted) return;

      switch (result) {
        case PaywallResult.purchased:
        case PaywallResult.restored:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('購入を復元しました')),
          );
          Navigator.of(context).pop();
          break;
        case PaywallResult.notPresented:
          // 既にEntitlementを持っている場合
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('既にプレミアムプランに加入中です')),
          );
          Navigator.of(context).pop();
          break;
        case PaywallResult.error:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('復元処理中にエラーが発生しました')),
          );
          break;
        case PaywallResult.cancelled:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('復元可能な購入がありませんでした')),
          );
          break;
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }
}

/// サブスク加入済みの場合のコンテンツ
class _SubscribedContent extends StatelessWidget {
  const _SubscribedContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'プレミアムプランに加入中です',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '広告が非表示になっています',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => _showCustomerCenter(context),
              icon: const Icon(Icons.manage_accounts),
              label: const Text('サブスクリプションを管理'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCustomerCenter(BuildContext context) async {
    try {
      await CustomerCenterService().presentCustomerCenter(context: context);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました: $e')),
      );
    }
  }
}

/// 購入コンテンツ
class _PurchaseContent extends StatelessWidget {
  const _PurchaseContent({
    required this.state,
    required this.viewModel,
  });

  final SubscriptionState state;
  final SubscriptionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (!state.hasPackages && !state.isProcessing) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('商品情報を読み込めませんでした'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.refreshOfferings,
              child: const Text('再読み込み'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _FeatureSection(),
              const SizedBox(height: 32),
              if (state.hasPackages) ...[
                _PlanCard(
                  title: '年額プラン',
                  package: state.annualPackage!,
                  isRecommended: true,
                  isAnnual: true,
                  onTap: state.isProcessing ? null : viewModel.purchaseAnnual,
                ),
                const SizedBox(height: 16),
                _PlanCard(
                  title: '月額プラン',
                  package: state.monthlyPackage!,
                  isRecommended: false,
                  isAnnual: false,
                  onTap: state.isProcessing ? null : viewModel.purchaseMonthly,
                ),
              ],
              const SizedBox(height: 24),
              TextButton(
                onPressed: state.isProcessing ? null : viewModel.restorePurchases,
                child: const Text('購入を復元'),
              ),
              const SizedBox(height: 16),
              const _LegalText(),
            ],
          ),
        ),
        if (state.isProcessing)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}

/// 機能紹介セクション
class _FeatureSection extends StatelessWidget {
  const _FeatureSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SaleBanner(),
        const SizedBox(height: 16),
        Icon(
          Icons.star,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        const Text(
          'プレミアムプラン',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        const _FeatureItem(
          icon: Icons.block,
          title: '広告を非表示',
          description: 'アプリ内のすべての広告が非表示になります',
        ),
        const SizedBox(height: 12),
        const _FeatureItem(
          icon: Icons.favorite,
          title: 'アプリ開発を応援',
          description: 'いただいた収益はアプリの改善に使わせていただきます',
        ),
      ],
    );
  }
}

/// 機能アイテム
class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// プランカード
class _PlanCard extends ConsumerWidget {
  const _PlanCard({
    required this.title,
    required this.package,
    required this.isRecommended,
    required this.isAnnual,
    this.onTap,
  });

  final String title;
  final Package package;
  final bool isRecommended;
  final bool isAnnual;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleInfo = ref.watch(subscriptionSaleInfoProvider);
    final priceString = package.storeProduct.priceString;
    final period = isAnnual ? '年' : '月';

    // プランに応じた割引率を取得
    final discountPercent = isAnnual
        ? saleInfo.yearlyDiscountPercent
        : saleInfo.monthlyDiscountPercent;
    final isOnSale = saleInfo.isActive && discountPercent > 0;

    return Card(
      elevation: isRecommended ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isRecommended
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isRecommended) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'おすすめ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$priceString / $period',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  if (isRecommended && !isOnSale) ...[
                    const SizedBox(height: 4),
                    Text(
                      '月額プランより約34%お得',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                  // セール時の追加メッセージ
                  if (isOnSale) ...[
                    const SizedBox(height: 4),
                    Text(
                      '通常価格より$discountPercent%OFF!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // セールバッジ
          if (isOnSale)
            Positioned(
              top: 0,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  '$discountPercent%OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 法的テキスト
class _LegalText extends StatelessWidget {
  const _LegalText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'サブスクリプションは自動更新されます。次の更新日の24時間前までにキャンセルしない限り、自動的に更新されます。アカウント設定からいつでもキャンセルできます。',
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }
}
