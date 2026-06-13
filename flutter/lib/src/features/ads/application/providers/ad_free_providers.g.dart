// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_free_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adFreeRepository)
const adFreeRepositoryProvider = AdFreeRepositoryProvider._();

final class AdFreeRepositoryProvider extends $FunctionalProvider<
    AdFreeRepository,
    AdFreeRepository,
    AdFreeRepository> with $Provider<AdFreeRepository> {
  const AdFreeRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adFreeRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adFreeRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdFreeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdFreeRepository create(Ref ref) {
    return adFreeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdFreeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdFreeRepository>(value),
    );
  }
}

String _$adFreeRepositoryHash() => r'ef950abd4d069fce98a9388b6265adf4d29bbe9d';

/// 広告非表示期限（DateTime?）を管理するNotifier

@ProviderFor(AdFreeUntil)
const adFreeUntilProvider = AdFreeUntilProvider._();

/// 広告非表示期限（DateTime?）を管理するNotifier
final class AdFreeUntilProvider
    extends $NotifierProvider<AdFreeUntil, DateTime?> {
  /// 広告非表示期限（DateTime?）を管理するNotifier
  const AdFreeUntilProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adFreeUntilProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adFreeUntilHash();

  @$internal
  @override
  AdFreeUntil create() => AdFreeUntil();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$adFreeUntilHash() => r'2f9cd481ece95b21591e46cb13b23d8527e8a7b6';

/// 広告非表示期限（DateTime?）を管理するNotifier

abstract class _$AdFreeUntil extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DateTime?, DateTime?>, DateTime?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// 広告非表示期限までの残り時間をリアルタイムに提供するStreamProvider
/// 1秒ごとに更新され、期限が切れた場合は null を返します

@ProviderFor(adFreeRemainingTime)
const adFreeRemainingTimeProvider = AdFreeRemainingTimeProvider._();

/// 広告非表示期限までの残り時間をリアルタイムに提供するStreamProvider
/// 1秒ごとに更新され、期限が切れた場合は null を返します

final class AdFreeRemainingTimeProvider extends $FunctionalProvider<
        AsyncValue<Duration?>, Duration?, Stream<Duration?>>
    with $FutureModifier<Duration?>, $StreamProvider<Duration?> {
  /// 広告非表示期限までの残り時間をリアルタイムに提供するStreamProvider
  /// 1秒ごとに更新され、期限が切れた場合は null を返します
  const AdFreeRemainingTimeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adFreeRemainingTimeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adFreeRemainingTimeHash();

  @$internal
  @override
  $StreamProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration?> create(Ref ref) {
    return adFreeRemainingTime(ref);
  }
}

String _$adFreeRemainingTimeHash() =>
    r'279e18915dd070b39c24f15b83ea13689215b4c3';

/// 現在、広告非表示期間が有効であるかどうかを判定するProvider

@ProviderFor(isAdFreeActive)
const isAdFreeActiveProvider = IsAdFreeActiveProvider._();

/// 現在、広告非表示期間が有効であるかどうかを判定するProvider

final class IsAdFreeActiveProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 現在、広告非表示期間が有効であるかどうかを判定するProvider
  const IsAdFreeActiveProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isAdFreeActiveProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isAdFreeActiveHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAdFreeActive(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAdFreeActiveHash() => r'07ee7fe946463e52e6d0742034a2984eecc92159';
