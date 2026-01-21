// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// サブスクリプション画面のViewModel

@ProviderFor(SubscriptionViewModel)
const subscriptionViewModelProvider = SubscriptionViewModelProvider._();

/// サブスクリプション画面のViewModel
final class SubscriptionViewModelProvider
    extends $NotifierProvider<SubscriptionViewModel, SubscriptionState> {
  /// サブスクリプション画面のViewModel
  const SubscriptionViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionViewModelHash();

  @$internal
  @override
  SubscriptionViewModel create() => SubscriptionViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubscriptionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubscriptionState>(value),
    );
  }
}

String _$subscriptionViewModelHash() =>
    r'eddb7fd43c3fd5fd7df5ac8d4ad1be47a8e1ede6';

/// サブスクリプション画面のViewModel

abstract class _$SubscriptionViewModel extends $Notifier<SubscriptionState> {
  SubscriptionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SubscriptionState, SubscriptionState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SubscriptionState, SubscriptionState>,
        SubscriptionState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
