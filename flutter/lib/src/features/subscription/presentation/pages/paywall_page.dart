import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../domain/entities/subscription_plan.dart';
import '../viewmodels/paywall_state.dart';
import '../viewmodels/paywall_view_model.dart';
import '../widgets/paywall_footer.dart';

/// プラン選択 + 購入ページ（2画面目）
class PaywallPage extends ConsumerWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paywallViewModelProvider);
    final vm = ref.read(paywallViewModelProvider.notifier);

    ref.listen<PaywallState>(
      paywallViewModelProvider,
      (previous, next) {
        final event = next.pendingUiEvent;
        if (event == null || event == previous?.pendingUiEvent) return;
        vm.clearUiEvent();
        event.map(
          showMessage: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(value.message)),
            );
          },
          purchaseCompleted: (_) {
            // intro → paywall の2画面を一気に閉じる
            context.pop();
            context.pop();
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: context.surfaceBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 戻るボタン + 閉じるボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => context.pop(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context.pop();
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody(context, state, vm)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PaywallState state,
    PaywallViewModel vm,
  ) {
    if (state.isLoadingOfferings) {
      return const Center(child: CircularProgressIndicator());
    }

    // offeringsError があり fallback でもない場合のみエラー画面
    if (state.offeringsError != null && !state.isFallbackMode) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: context.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                state.offeringsError!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: context.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: vm.reloadOfferings,
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
      );
    }

    final hasFreeTrial = _hasFreeTrial(state);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildCompactHeader(context),
                const SizedBox(height: 24),
                _buildPlanCards(context, state, vm),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _buildBottomPurchase(context, state, vm, hasFreeTrial),
      ],
    );
  }

  bool _hasFreeTrial(PaywallState state) {
    if (state.isFallbackMode) return true; // フォールバック時はトライアルありと仮定
    final intro = state.selectedPackage?.storeProduct.introductoryPrice;
    return intro != null && intro.price == 0;
  }

  Widget _buildCompactHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/icons/milu_bear.png',
                width: 48,
                height: 48,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'milu プレミアム',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'プランを選択してください',
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCards(
    BuildContext context,
    PaywallState state,
    PaywallViewModel vm,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _PlanSelectionCard(
            plan: SubscriptionPlan.yearly,
            package: state.packageForPlan(SubscriptionPlan.yearly),
            monthlyPackage: state.packageForPlan(SubscriptionPlan.monthly),
            isSelected: state.selectedPlan == SubscriptionPlan.yearly,
            isFallbackMode: state.isFallbackMode,
            onTap: () => vm.selectPlan(SubscriptionPlan.yearly),
          ),
          const SizedBox(height: 12),
          _PlanSelectionCard(
            plan: SubscriptionPlan.monthly,
            package: state.packageForPlan(SubscriptionPlan.monthly),
            isSelected: state.selectedPlan == SubscriptionPlan.monthly,
            isFallbackMode: state.isFallbackMode,
            onTap: () => vm.selectPlan(SubscriptionPlan.monthly),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPurchase(
    BuildContext context,
    PaywallState state,
    PaywallViewModel vm,
    bool hasFreeTrial,
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
              onPressed: state.canPurchase ? vm.purchase : null,
              style: FilledButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: context.onPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: state.isPurchasing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      hasFreeTrial ? '無料トライアルを開始' : 'サブスクリプションに登録',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasFreeTrial ? '1週間のトライアル後、選択したプランで自動更新されます。' : 'いつでもキャンセルできます。',
            style: TextStyle(
              fontSize: 12,
              color: context.subtextColor,
            ),
          ),
          PaywallFooter(
            isRestoring: state.isRestoring,
            onRestore: vm.restorePurchases,
          ),
        ],
      ),
    );
  }
}

/// プラン選択カード（縦並び・リッチ版）
class _PlanSelectionCard extends StatelessWidget {
  const _PlanSelectionCard({
    required this.plan,
    required this.package,
    required this.isSelected,
    required this.onTap,
    this.monthlyPackage,
    this.isFallbackMode = false,
  });

  final SubscriptionPlan plan;
  final Package? package;
  final bool isSelected;
  final VoidCallback onTap;
  final Package? monthlyPackage;
  final bool isFallbackMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? context.primaryColor.withValues(alpha: 0.06)
              : context.menuSectionBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? context.primaryColor : context.menuSectionBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        _titleForPlan(plan),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimary,
                        ),
                      ),
                      if (plan == SubscriptionPlan.yearly)
                        _buildDiscountBadge(context),
                    ],
                  ),
                ),
                _buildRadio(context),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _priceText(),
              style: TextStyle(
                fontSize: 14,
                color: context.textSecondary,
              ),
            ),
            if (plan == SubscriptionPlan.yearly) ...[
              const SizedBox(height: 4),
              Text(
                _monthlyEquivalentText(),
                style: TextStyle(
                  fontSize: 12,
                  color: context.subtextColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountBadge(BuildContext context) {
    final int discount;
    if (!isFallbackMode && package != null && monthlyPackage != null) {
      final yearlyPrice = package!.storeProduct.price;
      final monthlyPrice = monthlyPackage!.storeProduct.price;
      if (monthlyPrice == 0) return const SizedBox();
      discount = ((1 - yearlyPrice / (monthlyPrice * 12)) * 100).round();
    } else {
      // フォールバック: ¥2,000/年 vs ¥200/月 → 約17%
      discount = 17;
    }

    if (discount <= 0) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '-$discount%',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRadio(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              isSelected ? context.primaryColor : context.menuSectionBorder,
          width: 2,
        ),
        color: isSelected ? context.primaryColor : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }

  String _titleForPlan(SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.yearly => '年割プラン',
      SubscriptionPlan.monthly => '月額プラン',
    };
  }

  String _priceText() {
    if (isFallbackMode) {
      return switch (plan) {
        SubscriptionPlan.yearly => '¥2,000/年',
        SubscriptionPlan.monthly => '¥200/月',
      };
    }
    if (package == null) return '-';
    final price = package!.storeProduct.priceString;
    return switch (plan) {
      SubscriptionPlan.yearly => '$price/年',
      SubscriptionPlan.monthly => '$price/月',
    };
  }

  String _monthlyEquivalentText() {
    if (isFallbackMode) return '(1ヶ月あたり約167円)';
    if (package == null) return '';
    final yearlyPrice = package!.storeProduct.price;
    final monthlyEquiv = (yearlyPrice / 12).ceil();
    return '(1ヶ月あたり約$monthlyEquiv円)';
  }
}
