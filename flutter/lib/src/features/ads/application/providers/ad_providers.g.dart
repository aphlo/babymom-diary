// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adRepository)
const adRepositoryProvider = AdRepositoryProvider._();

final class AdRepositoryProvider
    extends $FunctionalProvider<AdRepository, AdRepository, AdRepository>
    with $Provider<AdRepository> {
  const AdRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdRepository create(Ref ref) {
    return adRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdRepository>(value),
    );
  }
}

String _$adRepositoryHash() => r'0a8af98df085b7bd495db654813179ffbecb3891';

@ProviderFor(adConfig)
const adConfigProvider = AdConfigProvider._();

final class AdConfigProvider
    extends $FunctionalProvider<AdConfig, AdConfig, AdConfig>
    with $Provider<AdConfig> {
  const AdConfigProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adConfigProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adConfigHash();

  @$internal
  @override
  $ProviderElement<AdConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdConfig create(Ref ref) {
    return adConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdConfig>(value),
    );
  }
}

String _$adConfigHash() => r'f88d2488273178e1ff291fdc671725a52683ba72';
