// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(childColorLocalStorage)
const childColorLocalStorageProvider = ChildColorLocalStorageProvider._();

final class ChildColorLocalStorageProvider extends $FunctionalProvider<
    ChildColorLocalStorage,
    ChildColorLocalStorage,
    ChildColorLocalStorage> with $Provider<ChildColorLocalStorage> {
  const ChildColorLocalStorageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'childColorLocalStorageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childColorLocalStorageHash();

  @$internal
  @override
  $ProviderElement<ChildColorLocalStorage> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChildColorLocalStorage create(Ref ref) {
    return childColorLocalStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChildColorLocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChildColorLocalStorage>(value),
    );
  }
}

String _$childColorLocalStorageHash() =>
    r'd2aaaa824b171c0edee9186b8fa0342a0f90ebd7';

/// 子供の色を管理するNotifier

@ProviderFor(ChildColor)
const childColorProvider = ChildColorProvider._();

/// 子供の色を管理するNotifier
final class ChildColorProvider
    extends $NotifierProvider<ChildColor, Map<String, Color>> {
  /// 子供の色を管理するNotifier
  const ChildColorProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'childColorProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childColorHash();

  @$internal
  @override
  ChildColor create() => ChildColor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Color> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Color>>(value),
    );
  }
}

String _$childColorHash() => r'7a62edb0665fcc7780a2092222dd2ed9bb5fa66d';

/// 子供の色を管理するNotifier

abstract class _$ChildColor extends $Notifier<Map<String, Color>> {
  Map<String, Color> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, Color>, Map<String, Color>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, Color>, Map<String, Color>>,
        Map<String, Color>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
