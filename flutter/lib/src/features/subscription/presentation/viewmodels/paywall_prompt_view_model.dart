import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../review_prompt/application/review_prompt_providers.dart';
import '../../application/providers/paywall_prompt_providers.dart';
import '../../application/providers/subscription_providers.dart';

/// Paywall自動表示のUI状態
class PaywallPromptViewState {
  const PaywallPromptViewState({
    this.shouldShowPaywall = false,
  });

  /// Paywallを表示すべきかどうか
  final bool shouldShowPaywall;

  PaywallPromptViewState copyWith({
    bool? shouldShowPaywall,
  }) {
    return PaywallPromptViewState(
      shouldShowPaywall: shouldShowPaywall ?? this.shouldShowPaywall,
    );
  }
}

/// Paywall自動表示のグローバルViewModel
class PaywallPromptViewModel extends Notifier<PaywallPromptViewState> {
  @override
  PaywallPromptViewState build() {
    return const PaywallPromptViewState();
  }

  /// 記録操作後に呼び出し
  ///
  /// レビュープロンプトが今回トリガーされた場合は重複を避けるためPaywallは表示しません。
  Future<void> onRecordAdded({required bool wasReviewPromptTriggered}) async {
    if (wasReviewPromptTriggered) return;

    final isPremium = ref.read(isPremiumProvider);
    if (isPremium) return;

    final reviewRepo = ref.read(reviewPromptRepositoryProvider);
    final reviewState = await reviewRepo.getState();

    final checkUseCase = ref.read(checkPaywallPromptRecordUseCaseProvider);
    final now = DateTime.now();

    final shouldShow = await checkUseCase(
      recordCount: reviewState.recordCount,
      now: now,
      isPremium: isPremium,
      reviewLastShownDate: reviewState.lastShownDate,
    );

    if (shouldShow) {
      final recordShownUseCase =
          ref.read(recordPaywallPromptShownUseCaseProvider);
      await recordShownUseCase(
        now: now,
        milestoneRecordCount: reviewState.recordCount,
      );
      state = state.copyWith(shouldShowPaywall: true);
    }
  }

  /// オンボーディング完了時に呼び出し
  Future<void> onOnboardingCompleted() async {
    final isPremium = ref.read(isPremiumProvider);
    if (isPremium) return;

    final checkUseCase = ref.read(checkPaywallPromptOnboardingUseCaseProvider);
    final now = DateTime.now();

    final shouldShow = await checkUseCase(
      now: now,
      isPremium: isPremium,
    );

    if (shouldShow) {
      final recordShownUseCase =
          ref.read(recordPaywallPromptShownUseCaseProvider);
      await recordShownUseCase(
        now: now,
        isOnboarding: true,
      );
      state = state.copyWith(shouldShowPaywall: true);
    }
  }

  /// Paywallを表示（UIレイヤーから呼び出し）
  void showPaywallIfNeeded(BuildContext context) {
    if (!state.shouldShowPaywall) return;
    state = state.copyWith(shouldShowPaywall: false);
    context.pushNamed('premium_intro');
  }
}

final paywallPromptViewModelProvider =
    NotifierProvider<PaywallPromptViewModel, PaywallPromptViewState>(
  PaywallPromptViewModel.new,
);
