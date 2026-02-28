import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../viewmodels/paywall_state.dart';
import '../viewmodels/paywall_view_model.dart';
import '../widgets/paywall_footer.dart';
import '../widgets/paywall_header.dart';
import '../widgets/paywall_plan_selector.dart';
import '../widgets/paywall_review_carousel.dart';

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
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
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

    if (state.offeringsError != null) {
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

    return SingleChildScrollView(
      child: Column(
        children: [
          const PaywallHeader(),
          const SizedBox(height: 8),
          const PaywallReviewCarousel(),
          const SizedBox(height: 8),
          PaywallPlanSelector(
            state: state,
            onSelectPlan: vm.selectPlan,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
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
                    : const Text(
                        '続ける',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          PaywallFooter(
            isRestoring: state.isRestoring,
            onRestore: vm.restorePurchases,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
