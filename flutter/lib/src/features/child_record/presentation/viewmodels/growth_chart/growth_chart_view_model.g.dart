// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_chart_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GrowthChartViewModel)
const growthChartViewModelProvider = GrowthChartViewModelProvider._();

final class GrowthChartViewModelProvider
    extends $NotifierProvider<GrowthChartViewModel, GrowthChartState> {
  const GrowthChartViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'growthChartViewModelProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$growthChartViewModelHash();

  @$internal
  @override
  GrowthChartViewModel create() => GrowthChartViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrowthChartState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrowthChartState>(value),
    );
  }
}

String _$growthChartViewModelHash() =>
    r'f6b25e2ffb3d304aed8e46f7be2c13c3c7fbbda6';

abstract class _$GrowthChartViewModel extends $Notifier<GrowthChartState> {
  GrowthChartState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GrowthChartState, GrowthChartState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<GrowthChartState, GrowthChartState>,
        GrowthChartState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
