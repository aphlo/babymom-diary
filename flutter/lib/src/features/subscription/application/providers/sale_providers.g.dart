// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// サブスクリプションのセール情報プロバイダー

@ProviderFor(subscriptionSaleInfo)
const subscriptionSaleInfoProvider = SubscriptionSaleInfoProvider._();

/// サブスクリプションのセール情報プロバイダー

final class SubscriptionSaleInfoProvider
    extends $FunctionalProvider<SaleInfo, SaleInfo, SaleInfo>
    with $Provider<SaleInfo> {
  /// サブスクリプションのセール情報プロバイダー
  const SubscriptionSaleInfoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionSaleInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionSaleInfoHash();

  @$internal
  @override
  $ProviderElement<SaleInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaleInfo create(Ref ref) {
    return subscriptionSaleInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaleInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaleInfo>(value),
    );
  }
}

String _$subscriptionSaleInfoHash() =>
    r'af9a2a3f4114abd81bdfa7f4ba5810195e84be07';
