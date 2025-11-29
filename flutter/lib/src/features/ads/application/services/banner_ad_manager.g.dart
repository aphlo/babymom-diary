// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_ad_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// BannerAdManagerのプロバイダー

@ProviderFor(bannerAdManager)
const bannerAdManagerProvider = BannerAdManagerProvider._();

/// BannerAdManagerのプロバイダー

final class BannerAdManagerProvider extends $FunctionalProvider<BannerAdManager,
    BannerAdManager, BannerAdManager> with $Provider<BannerAdManager> {
  /// BannerAdManagerのプロバイダー
  const BannerAdManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bannerAdManagerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bannerAdManagerHash();

  @$internal
  @override
  $ProviderElement<BannerAdManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BannerAdManager create(Ref ref) {
    return bannerAdManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BannerAdManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BannerAdManager>(value),
    );
  }
}

String _$bannerAdManagerHash() => r'f221f752ddc3cdf9b156223347508a48836afd4f';
