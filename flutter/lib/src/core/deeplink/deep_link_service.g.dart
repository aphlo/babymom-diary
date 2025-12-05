// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_link_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deepLinkService)
const deepLinkServiceProvider = DeepLinkServiceProvider._();

final class DeepLinkServiceProvider extends $FunctionalProvider<DeepLinkService,
    DeepLinkService, DeepLinkService> with $Provider<DeepLinkService> {
  const DeepLinkServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'deepLinkServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deepLinkServiceHash();

  @$internal
  @override
  $ProviderElement<DeepLinkService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeepLinkService create(Ref ref) {
    return deepLinkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeepLinkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeepLinkService>(value),
    );
  }
}

String _$deepLinkServiceHash() => r'9f8b924f987a56efab29845af27c9c8aa72b946a';
