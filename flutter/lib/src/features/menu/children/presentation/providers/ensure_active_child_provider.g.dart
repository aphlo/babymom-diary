// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ensure_active_child_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// EnsureActiveChild UseCase の Provider

@ProviderFor(ensureActiveChild)
const ensureActiveChildProvider = EnsureActiveChildProvider._();

/// EnsureActiveChild UseCase の Provider

final class EnsureActiveChildProvider extends $FunctionalProvider<
    EnsureActiveChild,
    EnsureActiveChild,
    EnsureActiveChild> with $Provider<EnsureActiveChild> {
  /// EnsureActiveChild UseCase の Provider
  const EnsureActiveChildProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ensureActiveChildProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ensureActiveChildHash();

  @$internal
  @override
  $ProviderElement<EnsureActiveChild> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EnsureActiveChild create(Ref ref) {
    return ensureActiveChild(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnsureActiveChild value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnsureActiveChild>(value),
    );
  }
}

String _$ensureActiveChildHash() => r'215f7f1ddd3727089ce311a7bc10632d19ad072f';
