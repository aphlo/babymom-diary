// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SubscriptionRepositoryのProvider

@ProviderFor(subscriptionRepository)
const subscriptionRepositoryProvider = SubscriptionRepositoryProvider._();

/// SubscriptionRepositoryのProvider

final class SubscriptionRepositoryProvider extends $FunctionalProvider<
    SubscriptionRepository,
    SubscriptionRepository,
    SubscriptionRepository> with $Provider<SubscriptionRepository> {
  /// SubscriptionRepositoryのProvider
  const SubscriptionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SubscriptionRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubscriptionRepository create(Ref ref) {
    return subscriptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubscriptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubscriptionRepository>(value),
    );
  }
}

String _$subscriptionRepositoryHash() =>
    r'5dea41a2f0ff3ff4539c1ee42ed405163eceefea';

/// サブスクリプション状態のStreamProvider

@ProviderFor(subscriptionStatus)
const subscriptionStatusProvider = SubscriptionStatusProvider._();

/// サブスクリプション状態のStreamProvider

final class SubscriptionStatusProvider extends $FunctionalProvider<
        AsyncValue<SubscriptionStatus>,
        SubscriptionStatus,
        Stream<SubscriptionStatus>>
    with
        $FutureModifier<SubscriptionStatus>,
        $StreamProvider<SubscriptionStatus> {
  /// サブスクリプション状態のStreamProvider
  const SubscriptionStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionStatusProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionStatusHash();

  @$internal
  @override
  $StreamProviderElement<SubscriptionStatus> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<SubscriptionStatus> create(Ref ref) {
    return subscriptionStatus(ref);
  }
}

String _$subscriptionStatusHash() =>
    r'63d1cd7119d9683302ac270f80e4dfab9f992389';

/// プレミアムかどうかの同期Provider（デフォルトfalse）

@ProviderFor(isPremium)
const isPremiumProvider = IsPremiumProvider._();

/// プレミアムかどうかの同期Provider（デフォルトfalse）

final class IsPremiumProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// プレミアムかどうかの同期Provider（デフォルトfalse）
  const IsPremiumProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isPremiumProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isPremiumHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isPremium(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isPremiumHash() => r'7750476b2b37cb3ff2fa2ab53bcd6266b1eb8f68';
