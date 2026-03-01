// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaywallViewModel)
const paywallViewModelProvider = PaywallViewModelProvider._();

final class PaywallViewModelProvider
    extends $NotifierProvider<PaywallViewModel, PaywallState> {
  const PaywallViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'paywallViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$paywallViewModelHash();

  @$internal
  @override
  PaywallViewModel create() => PaywallViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaywallState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaywallState>(value),
    );
  }
}

String _$paywallViewModelHash() => r'bf40588654f143eacc816fc7d4a18f4c9585ac0d';

abstract class _$PaywallViewModel extends $Notifier<PaywallState> {
  PaywallState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PaywallState, PaywallState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PaywallState, PaywallState>,
        PaywallState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
