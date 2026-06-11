import 'dart:ui';
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
            context.pop(); // 1画面に統合されたため、popは1回だけ
          },
        );
      },
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? [
            const Color(0xFF2E1A25), // ほんのりピンクがかった極暗色
            const Color(0xFF19121E), // 深い紫・ゴールド寄り
            const Color(0xFF121214), // 背景の通常ダークカラー
          ]
        : [
            const Color(0xFFFFECEF), // 柔らかな薄いピンク
            const Color(0xFFFFF7E6), // やさしいゴールド
            Colors.white,
          ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // 閉じるボタンのみを右上に配置
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: context.textPrimary,
                    ),
                    onPressed: () => context.pop(), // popは1回だけ
                  ),
                ),
              ),
              Expanded(child: _buildBody(context, state, vm)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PaywallState state,
    PaywallViewModel vm,
  ) {
    // offeringsError があり fallback でもない場合のみエラー画面（ロード中ではないときのみ判定）
    if (state.offeringsError != null &&
        !state.isFallbackMode &&
        !state.isLoadingOfferings) {
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
                _buildHeader(context),
                const SizedBox(height: 8),
                _buildBenefits(context),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'プランを選択してください',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (state.isLoadingOfferings)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.primaryColor,
                      ),
                    ),
                  )
                else
                  _buildPlanCards(context, state, vm),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        if (state.isLoadingOfferings)
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                decoration: BoxDecoration(
                  color: context.surfaceBackground.withValues(alpha: 0.85),
                  border: Border(
                    top: BorderSide(
                      color: context.menuSectionBorder.withValues(alpha: 0.4),
                      width: 0.5,
                    ),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CircularProgressIndicator(
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          _buildBottomPurchase(context, state, vm, hasFreeTrial),
      ],
    );
  }

  bool _hasFreeTrial(PaywallState state) {
    if (state.isFallbackMode) return true; // フォールバック時はトライアルありと仮定
    final intro = state.selectedPackage?.storeProduct.introductoryPrice;
    return intro != null && intro.price == 0;
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24), // 上部余白を増やして王冠の見切れを防ぐ
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: context.primaryColor.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/milu_bear.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -8, // 少し内側に寄せて見切れを防ぐ
                right: -8, // 少し内側に寄せて見切れを防ぐ
                child: Transform.rotate(
                  angle: 0.15,
                  child: const Icon(
                    Icons.workspace_premium,
                    color: Color(0xFFFBC02D), // ゴールド王冠
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFE87086), Color(0xFFFFA726)],
            ).createShader(bounds),
            child: const Text(
              'milu プレミアム',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '広告なしで快適に。もっと便利に。',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefits(BuildContext context) {
    final benefits = [
      (
        icon: Icons.block_outlined,
        title: '広告を完全削除',
        description: 'バナー広告を非表示にして、ストレスなく快適に記録ができます',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.menuSectionBackground.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.menuSectionBorder.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'プレミアム限定機能',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                ...benefits.map(
                  (b) => Padding(
                    padding: EdgeInsets.only(
                      bottom: b == benefits.last ? 0 : 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: context.primaryColor.withValues(alpha: 0.12),
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
                                  height: 1.4,
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
        ),
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          decoration: BoxDecoration(
            color: context.surfaceBackground.withValues(alpha: 0.85),
            border: Border(
              top: BorderSide(
                color: context.menuSectionBorder.withValues(alpha: 0.4),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE87086), Color(0xFFFFA726)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE87086).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    onPressed: state.canPurchase ? vm.purchase : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
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
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  hasFreeTrial
                      ? '1週間のトライアル後、選択したプランで自動更新されます。'
                      : 'いつでもキャンセルできます。',
                  style: TextStyle(
                    fontSize: 11,
                    color: context.subtextColor,
                  ),
                ),
                PaywallFooter(
                  isRestoring: state.isRestoring,
                  onRestore: vm.restorePurchases,
                ),
              ],
            ),
          ),
        ),
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
    final isYearly = plan == SubscriptionPlan.yearly;
    final goldColor = const Color(0xFFFFA726);

    Border borderBorderSide() {
      if (isYearly) {
        return Border.all(
          color: isSelected ? goldColor : goldColor.withValues(alpha: 0.4),
          width: isSelected ? 2.5 : 1,
        );
      }
      return Border.all(
        color: isSelected
            ? context.primaryColor
            : context.menuSectionBorder.withValues(alpha: 0.5),
        width: isSelected ? 2 : 1,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.primaryColor.withValues(alpha: 0.08)
                  : context.menuSectionBackground.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(16),
              border: borderBorderSide(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isYearly)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: goldColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'おすすめ',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          if (isYearly) _buildDiscountBadge(context),
                        ],
                      ),
                    ),
                    _buildRadio(context),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _priceText(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? (isYearly ? goldColor : context.primaryColor)
                        : context.textPrimary,
                  ),
                ),
                if (isYearly) ...[
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
    final goldColor = const Color(0xFFFFA726);
    final activeColor =
        plan == SubscriptionPlan.yearly ? goldColor : context.primaryColor;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? activeColor
              : context.menuSectionBorder.withValues(alpha: 0.5),
          width: 2,
        ),
        color: isSelected ? activeColor : Colors.transparent,
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
