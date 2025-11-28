// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_chart_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(growthChartSettingsStorage)
const growthChartSettingsStorageProvider =
    GrowthChartSettingsStorageProvider._();

final class GrowthChartSettingsStorageProvider extends $FunctionalProvider<
    GrowthChartSettingsStorage,
    GrowthChartSettingsStorage,
    GrowthChartSettingsStorage> with $Provider<GrowthChartSettingsStorage> {
  const GrowthChartSettingsStorageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'growthChartSettingsStorageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$growthChartSettingsStorageHash();

  @$internal
  @override
  $ProviderElement<GrowthChartSettingsStorage> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GrowthChartSettingsStorage create(Ref ref) {
    return growthChartSettingsStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrowthChartSettingsStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrowthChartSettingsStorage>(value),
    );
  }
}

String _$growthChartSettingsStorageHash() =>
    r'44339f38202a926a88ce7764b917bbf220fcd2c8';

/// 成長曲線の設定を管理するNotifier

@ProviderFor(GrowthChartSettings)
const growthChartSettingsProvider = GrowthChartSettingsProvider._();

/// 成長曲線の設定を管理するNotifier
final class GrowthChartSettingsProvider
    extends $NotifierProvider<GrowthChartSettings, bool> {
  /// 成長曲線の設定を管理するNotifier
  const GrowthChartSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'growthChartSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$growthChartSettingsHash();

  @$internal
  @override
  GrowthChartSettings create() => GrowthChartSettings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$growthChartSettingsHash() =>
    r'b98021440ad3031fbde1fcd3bca76e315c5562cf';

/// 成長曲線の設定を管理するNotifier

abstract class _$GrowthChartSettings extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
