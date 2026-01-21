// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RevenueCatサービスのプロバイダー

@ProviderFor(revenueCatService)
const revenueCatServiceProvider = RevenueCatServiceProvider._();

/// RevenueCatサービスのプロバイダー

final class RevenueCatServiceProvider extends $FunctionalProvider<
    RevenueCatService,
    RevenueCatService,
    RevenueCatService> with $Provider<RevenueCatService> {
  /// RevenueCatサービスのプロバイダー
  const RevenueCatServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'revenueCatServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$revenueCatServiceHash();

  @$internal
  @override
  $ProviderElement<RevenueCatService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RevenueCatService create(Ref ref) {
    return revenueCatService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RevenueCatService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RevenueCatService>(value),
    );
  }
}

String _$revenueCatServiceHash() => r'bb2b55f3f17ff5332ef5dd58cf69cf6692564935';

/// サブスクリプションリポジトリのプロバイダー

@ProviderFor(subscriptionRepository)
const subscriptionRepositoryProvider = SubscriptionRepositoryProvider._();

/// サブスクリプションリポジトリのプロバイダー

final class SubscriptionRepositoryProvider extends $FunctionalProvider<
    SubscriptionRepository,
    SubscriptionRepository,
    SubscriptionRepository> with $Provider<SubscriptionRepository> {
  /// サブスクリプションリポジトリのプロバイダー
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
    r'4da65d7a0b7eb86135c8431673c18cab750f1923';

/// サブスクリプション状態のストリームプロバイダー

@ProviderFor(subscriptionStatusStream)
const subscriptionStatusStreamProvider = SubscriptionStatusStreamProvider._();

/// サブスクリプション状態のストリームプロバイダー

final class SubscriptionStatusStreamProvider extends $FunctionalProvider<
        AsyncValue<SubscriptionStatus>,
        SubscriptionStatus,
        Stream<SubscriptionStatus>>
    with
        $FutureModifier<SubscriptionStatus>,
        $StreamProvider<SubscriptionStatus> {
  /// サブスクリプション状態のストリームプロバイダー
  const SubscriptionStatusStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionStatusStreamProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionStatusStreamHash();

  @$internal
  @override
  $StreamProviderElement<SubscriptionStatus> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<SubscriptionStatus> create(Ref ref) {
    return subscriptionStatusStream(ref);
  }
}

String _$subscriptionStatusStreamHash() =>
    r'9ccae0821aea32ddebcbca0f97fd80929667f117';

/// 現在のサブスクリプション状態を取得するプロバイダー

@ProviderFor(subscriptionStatus)
const subscriptionStatusProvider = SubscriptionStatusProvider._();

/// 現在のサブスクリプション状態を取得するプロバイダー

final class SubscriptionStatusProvider extends $FunctionalProvider<
        AsyncValue<SubscriptionStatus>,
        SubscriptionStatus,
        FutureOr<SubscriptionStatus>>
    with
        $FutureModifier<SubscriptionStatus>,
        $FutureProvider<SubscriptionStatus> {
  /// 現在のサブスクリプション状態を取得するプロバイダー
  const SubscriptionStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionStatusHash();

  @$internal
  @override
  $FutureProviderElement<SubscriptionStatus> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SubscriptionStatus> create(Ref ref) {
    return subscriptionStatus(ref);
  }
}

String _$subscriptionStatusHash() =>
    r'77a1d78673ed2d46656bbb4b416645c680149b95';

/// 広告を表示するべきかどうか

@ProviderFor(shouldShowAds)
const shouldShowAdsProvider = ShouldShowAdsProvider._();

/// 広告を表示するべきかどうか

final class ShouldShowAdsProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 広告を表示するべきかどうか
  const ShouldShowAdsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'shouldShowAdsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$shouldShowAdsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return shouldShowAds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$shouldShowAdsHash() => r'51be0620ae8fc94bf02dccd600df5ba2ecb884a4';

/// サブスクが有効かどうか（同期的に取得）

@ProviderFor(isSubscriptionActive)
const isSubscriptionActiveProvider = IsSubscriptionActiveProvider._();

/// サブスクが有効かどうか（同期的に取得）

final class IsSubscriptionActiveProvider
    extends $FunctionalProvider<bool, bool, bool> with $Provider<bool> {
  /// サブスクが有効かどうか（同期的に取得）
  const IsSubscriptionActiveProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isSubscriptionActiveProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isSubscriptionActiveHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSubscriptionActive(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSubscriptionActiveHash() =>
    r'528cc2512dc0549b4d6e45b88a65b881e24b54b5';

/// 利用可能なオファリング（商品一覧）

@ProviderFor(offerings)
const offeringsProvider = OfferingsProvider._();

/// 利用可能なオファリング（商品一覧）

final class OfferingsProvider extends $FunctionalProvider<
        AsyncValue<Offerings?>, Offerings?, FutureOr<Offerings?>>
    with $FutureModifier<Offerings?>, $FutureProvider<Offerings?> {
  /// 利用可能なオファリング（商品一覧）
  const OfferingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'offeringsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$offeringsHash();

  @$internal
  @override
  $FutureProviderElement<Offerings?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Offerings?> create(Ref ref) {
    return offerings(ref);
  }
}

String _$offeringsHash() => r'9fc4b01885e4e6d4ecbf7c5a7ceb89b870c5051b';
