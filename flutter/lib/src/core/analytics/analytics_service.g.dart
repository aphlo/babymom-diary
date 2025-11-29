// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// FirebaseAnalyticsのインスタンスを提供

@ProviderFor(firebaseAnalytics)
const firebaseAnalyticsProvider = FirebaseAnalyticsProvider._();

/// FirebaseAnalyticsのインスタンスを提供

final class FirebaseAnalyticsProvider extends $FunctionalProvider<
    FirebaseAnalytics,
    FirebaseAnalytics,
    FirebaseAnalytics> with $Provider<FirebaseAnalytics> {
  /// FirebaseAnalyticsのインスタンスを提供
  const FirebaseAnalyticsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseAnalyticsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseAnalyticsHash();

  @$internal
  @override
  $ProviderElement<FirebaseAnalytics> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAnalytics create(Ref ref) {
    return firebaseAnalytics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAnalytics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAnalytics>(value),
    );
  }
}

String _$firebaseAnalyticsHash() => r'50223a2a038fe07ae55006344e88f86923613e7d';

/// Analyticsが有効かどうかを管理するProvider
/// main_prod.dartでtrueにoverrideする

@ProviderFor(analyticsEnabled)
const analyticsEnabledProvider = AnalyticsEnabledProvider._();

/// Analyticsが有効かどうかを管理するProvider
/// main_prod.dartでtrueにoverrideする

final class AnalyticsEnabledProvider
    extends $FunctionalProvider<bool, bool, bool> with $Provider<bool> {
  /// Analyticsが有効かどうかを管理するProvider
  /// main_prod.dartでtrueにoverrideする
  const AnalyticsEnabledProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'analyticsEnabledProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$analyticsEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return analyticsEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$analyticsEnabledHash() => r'21f0f3da5c9aa21a8b89c13efef35d2a956751a5';

/// AnalyticsServiceのインスタンスを提供

@ProviderFor(analyticsService)
const analyticsServiceProvider = AnalyticsServiceProvider._();

/// AnalyticsServiceのインスタンスを提供

final class AnalyticsServiceProvider extends $FunctionalProvider<
    AnalyticsService,
    AnalyticsService,
    AnalyticsService> with $Provider<AnalyticsService> {
  /// AnalyticsServiceのインスタンスを提供
  const AnalyticsServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'analyticsServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$analyticsServiceHash();

  @$internal
  @override
  $ProviderElement<AnalyticsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsService create(Ref ref) {
    return analyticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsService>(value),
    );
  }
}

String _$analyticsServiceHash() => r'e00f0ee58eb17665f37af0a2aaa17bd2b7c9c68f';
